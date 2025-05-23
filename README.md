# Ansible Collection: community.windows

[![Build Status](https://dev.azure.com/ansible/community.windows/_apis/build/status/CI?branchName=main)](https://dev.azure.com/ansible/community.windows/_build/latest?definitionId=23&branchName=main)
[![codecov](https://codecov.io/gh/ansible-collections/community.windows/branch/main/graph/badge.svg)](https://codecov.io/gh/ansible-collections/community.windows)


The `community.windows` collection includes the community plugins supported by Ansible community to help the management of Windows hosts.

## Communication

* Join the Ansible forum:
  * [Get Help](https://forum.ansible.com/c/help/6): get help or help others.
  * [Posts tagged with 'windows'](https://forum.ansible.com/tag/windows): subscribe to participate in collection-related conversations.
  * [Social Spaces](https://forum.ansible.com/c/chat/4): gather and interact with fellow enthusiasts.
  * [News & Announcements](https://forum.ansible.com/c/news/5): track project-wide announcements including social events.

* The Ansible [Bullhorn newsletter](https://docs.ansible.com/ansible/devel/community/communication.html#the-bullhorn): used to announce releases and important changes.

For more information about communication, see the [Ansible communication guide](https://docs.ansible.com/ansible/devel/community/communication.html).

## Ansible version compatibility

This collection has been tested against following Ansible versions: **>=2.16**.

Plugins and modules within a collection may be tested with only specific Ansible versions.
A collection may contain metadata that identifies these versions.
PEP440 is the schema used to describe the versions of Ansible.

## Changelog

See [CHANGELOG.rst](https://github.com/ansible-collections/community.windows/blob/main/CHANGELOG.rst) for the release history and changes made to this collection.

## Collection Documentation

Browsing the [**latest** collection documentation](https://docs.ansible.com/ansible/latest/collections/community/windows) will show docs for the _latest version released in the Ansible package_ not the latest version of the collection released on Galaxy.

Browsing the [**devel** collection documentation](https://docs.ansible.com/ansible/devel/collections/community/windows) shows docs for the _latest version released on Galaxy_.

We also separately publish [**latest commit** collection documentation](https://ansible-collections.github.io/community.windows/branch/main/) which shows docs for the _latest commit in the `main` branch_.

If you use the Ansible package and don't update collections independently, use **latest**, if you install or update this collection directly from Galaxy, use **devel**. If you are looking to contribute, use **latest commit**.

## Installation and Usage

### Installing the Collection from Ansible Galaxy

Before using the Windows collection, you need to install it with the `ansible-galaxy` CLI:

    ansible-galaxy collection install community.windows

You can also include it in a `requirements.yml` file and install it via `ansible-galaxy collection install -r requirements.yml` using the format:

```yaml
collections:
- name: community.windows
```


## Contributing to this collection

Currently we welcome bugfixes or feature requests to plugins in this collection but no new modules or plugins will be accepted in this collection. If you find problems, please open an issue or create a PR against the [Community Windows collection repository](https://github.com/ansible-collections/community.windows). See [Contributing to Ansible-maintained collections](https://docs.ansible.com/ansible/devel/community/contributing_maintained_collections.html#contributing-maintained-collections) for details.

See [Developing modules for Windows](https://docs.ansible.com/ansible/latest/dev_guide/developing_modules_general_windows.html#developing-modules-general-windows) for specifics on Windows modules.

See the [Ansible Community Guide](https://docs.ansible.com/ansible/latest/community/index.html) for details on contributing to Ansible.


### Code of Conduct
This collection follows the Ansible project's
[Code of Conduct](https://docs.ansible.com/ansible/devel/community/code_of_conduct.html).
Please read and familiarize yourself with this document.


### Testing with `ansible-test`

The `tests` directory contains configuration for running sanity and integration tests using [`ansible-test`](https://docs.ansible.com/ansible/latest/dev_guide/testing_integration.html).

You can run the collection's test suites with the commands:

    ansible-test sanity --docker
    ansible-test windows-integration --docker


## Publishing New Version

The current process for publishing new versions of the Windows Core Collection is manual, and requires a user who has access to the `community` namespace on Ansible Galaxy and Automation Hub to publish the build artifact.
* Update `galaxy.yml` with the new version for the collection.
* Update the `CHANGELOG`:
  * Make sure you have [`antsibull-changelog`](https://pypi.org/project/antsibull-changelog/) installed `pip install antsibull-changelog`.
  * Make sure there are fragments for all known changes in `changelogs/fragments`.
  * Add a new `release_summary` fragment: `echo "release_summary: Release summary for v..." > changelogs/fragments/release-summary.yml`
  * Run `antsibull-changelog release`.
* Commit the changes and wait for CI to be green
* Create a release with the tag that matches the version number
  * The tag is the version number itself, and should not start with anything
  * This will trigger a build and publish the collection to Galaxy
  * The Zuul job progress will be listed [here](https://ansible.softwarefactory-project.io/zuul/builds?project=ansible-collections%community.windows&skip=0)

After the version is published, verify it exists on the [Windows Community Collection Galaxy page](https://galaxy.ansible.com/community/windows).


## More Information

For more information about Ansible's Windows integration, join the `#ansible-windows` channel on [libera.chat](https://libera.chat/) IRC, and browse the resources in the [Windows Working Group](https://github.com/ansible/community/wiki/Windows) Community wiki page.

- [Ansible Collection overview](https://github.com/ansible-collections/overview)
- [Ansible User guide](https://docs.ansible.com/ansible/latest/user_guide/index.html)
- [Ansible Developer guide](https://docs.ansible.com/ansible/latest/dev_guide/index.html)
- [Ansible Community code of conduct](https://docs.ansible.com/ansible/latest/community/code_of_conduct.html)


## License

GNU General Public License v3.0 or later

See [COPYING](COPYING) to see the full text.
