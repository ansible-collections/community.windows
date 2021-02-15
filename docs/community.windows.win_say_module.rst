.. _community.windows.win_say_module:


*************************
community.windows.win_say
*************************

**Text to speech module for Windows to speak messages and optionally play sounds**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Uses .NET libraries to convert text to speech and optionally play .wav sounds.  Audio Service needs to be running and some kind of speakers or headphones need to be attached to the windows target(s) for the speech to be audible.




Parameters
----------

.. raw:: html

    <table  border=0 cellpadding=0 class="documentation-table">
        <tr>
            <th colspan="1">Parameter</th>
            <th>Choices/<font color="blue">Defaults</font></th>
            <th width="100%">Comments</th>
        </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>end_sound_path</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Full path to a <code>.wav</code> file containing a sound to play after the text has been spoken.</div>
                        <div>Useful on conference calls to alert other speakers that ansible has finished speaking.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>msg</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The text to be spoken.</div>
                        <div>Use either <code>msg</code> or <code>msg_file</code>.</div>
                        <div>Optional so that you can use this module just to play sounds.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>msg_file</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Full path to a windows format text file containing the text to be spoken.</div>
                        <div>Use either <code>msg</code> or <code>msg_file</code>.</div>
                        <div>Optional so that you can use this module just to play sounds.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>speech_speed</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">0</div>
                </td>
                <td>
                        <div>How fast or slow to speak the text.</div>
                        <div>Must be an integer value in the range -10 to 10.</div>
                        <div>-10 is slowest, 10 is fastest.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>start_sound_path</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Full path to a <code>.wav</code> file containing a sound to play before the text is spoken.</div>
                        <div>Useful on conference calls to alert other speakers that ansible has something to say.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>voice</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Which voice to use. See notes for how to discover installed voices.</div>
                        <div>If the requested voice is not available the default voice will be used. Example voice names from Windows 10 are <code>Microsoft Zira Desktop</code> and <code>Microsoft Hazel Desktop</code>.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - Needs speakers or headphones to do anything useful.
   - To find which voices are installed, run the following Powershell commands.

            Add-Type -AssemblyName System.Speech
            $speech = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
            $speech.GetInstalledVoices() | ForEach-Object { $_.VoiceInfo }
            $speech.Dispose()

   - Speech can be surprisingly slow, so it's best to keep message text short.


See Also
--------

.. seealso::

   :ref:`community.windows.win_msg_module`
      The official documentation on the **community.windows.win_msg** module.
   :ref:`community.windows.win_toast_module`
      The official documentation on the **community.windows.win_toast** module.


Examples
--------

.. code-block:: yaml

    - name: Warn of impending deployment
      community.windows.win_say:
        msg: Warning, deployment commencing in 5 minutes, please log out.

    - name: Using a different voice and a start sound
      community.windows.win_say:
        start_sound_path: C:\Windows\Media\ding.wav
        msg: Warning, deployment commencing in 5 minutes, please log out.
        voice: Microsoft Hazel Desktop

    - name: With start and end sound
      community.windows.win_say:
        start_sound_path: C:\Windows\Media\Windows Balloon.wav
        msg: New software installed
        end_sound_path: C:\Windows\Media\chimes.wav

    - name: Text from file example
      community.windows.win_say:
        start_sound_path: C:\Windows\Media\Windows Balloon.wav
        msg_file: AppData\Local\Temp\morning_report.txt
        end_sound_path: C:\Windows\Media\chimes.wav



Return Values
-------------
Common return values are documented `here <https://docs.ansible.com/ansible/latest/reference_appendices/common_return_values.html#common-return-values>`_, the following are the fields unique to this module:

.. raw:: html

    <table border=0 cellpadding=0 class="documentation-table">
        <tr>
            <th colspan="1">Key</th>
            <th>Returned</th>
            <th width="100%">Description</th>
        </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>message_text</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>The text that the module attempted to speak.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Warning, deployment commencing in 5 minutes.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>voice</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>The voice used to speak the text.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Microsoft Hazel Desktop</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>voice_info</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>when requested voice could not be loaded</td>
                <td>
                            <div>The voice used to speak the text.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Could not load voice TestVoice, using system default voice</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Jon Hawkesworth (@jhawkesworth)
