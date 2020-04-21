# Copyright: (c) 2018, Ansible Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

import ntpath
import time

from ansible.errors import AnsibleError
from ansible.plugins.action import ActionBase
from ansible.utils.vars import merge_hash
from ansible.utils.display import Display
display = Display()


class ActionModule(ActionBase):
    _default_async_timeout = 300
    _default_async_poll = 1

    def __init__(self, *args, **kwargs):
        super(ActionModule, self).__init__(*args, **kwargs)

    def run(self, tmp=None, task_vars=None):
        self._supports_check_mode = True
        self._supports_async = True
        check_mode = self._play_context.check_mode
        async_timeout = self._task.async_val
        async_poll = self._task.poll

        # fake out the super so it doesn't stop us from using check mode with async
        if check_mode:
            self._task.async_val = None

        result = super(ActionModule, self).run(tmp, task_vars)

        # build the wait_for_connection object for later use
        wait_for_connection_task = self._task.copy()
        wait_for_connection_task.args = {
            'timeout': async_timeout or self._default_async_timeout,
            'sleep': async_poll or self._default_async_poll
        }
        wait_connection_action = self._shared_loader_obj.action_loader.get(
            'wait_for_connection',
            task=wait_for_connection_task,
            connection=self._connection,
            play_context=self._play_context,
            loader=self._loader,
            templar=self._templar,
            shared_loader_obj=self._shared_loader_obj
        )

        # if it's not in check mode, call the module async so the WinRM restart doesn't kill ansible
        if not check_mode:
            self._task.async_val = async_timeout or self._default_async_timeout

        result = status = self._execute_module(
            task_vars=task_vars,
            module_args=self._task.args
        )
        display.vvvv("Internal Async Result: %r" % status)

        # if we're in check mode (not doing async) or not polling, return the result now
        if check_mode or async_poll == 0:
            return result

        # remove the async flag so that our calls to async_status and wait_for_connection don't try to run async
        self._task.async_val = None

        async_status_args = {
            'jid': status['ansible_job_id'],
            '_async_dir': ntpath.dirname(status['results_file'])
        }

        # Retries here is a fallback in case the module fails in an unexpected way
        # which can sometimes not properly set the finished field in the return.
        # It is not related to async retries.
        # Without this, that situation would cause an infinite loop.
        max_retries = 3
        retries = 0
        while not check_mode:
            try:
                # check up on the async job
                job_status = self._execute_module(
                    module_name='async_status',
                    module_args=async_status_args,
                    task_vars=task_vars,
                    wrap_async=False
                )
                display.vvvv("Async Job Status: %r" % job_status)

                if job_status.get('failed', False):
                    raise AnsibleError(job_status.get('msg', job_status))

                if job_status.get('finished', False):
                    result = job_status
                    break

                time.sleep(self._task.poll)

            except BaseException as e:
                retries += 1
                if retries >= max_retries:
                    display.vvvv("Max retries reached.")
                    raise e
                display.vvvv("Retrying (%s of %s)" % (retries, max_retries))
                display.vvvv("Falling back to wait_for_connection: %r" % e)
                wait_connection_action.run(task_vars=task_vars)

        return result
