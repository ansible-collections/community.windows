.. _community.windows.win_xml_module:


*************************
community.windows.win_xml
*************************

**Manages XML file content on Windows hosts**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Manages XML nodes, attributes and text, using xpath to select which xml nodes need to be managed.
- XML fragments, formatted as strings, are used to specify the desired state of a part or parts of XML files on remote Windows servers.
- For non-Windows targets, use the :ref:`community.general.xml <community.general.xml_module>` module instead.




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
                    <b>attribute</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The attribute name if the type is &#x27;attribute&#x27;.</div>
                        <div>Required if <code>type=attribute</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>backup</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>no</b>&nbsp;&larr;</div></li>
                                    <li>yes</li>
                        </ul>
                </td>
                <td>
                        <div>Determine whether a backup should be created.</div>
                        <div>When set to <code>yes</code>, create a backup file including the timestamp information so you can get the original file back if you somehow clobbered it incorrectly.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>count</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>no</b>&nbsp;&larr;</div></li>
                                    <li>yes</li>
                        </ul>
                </td>
                <td>
                        <div>When set to <code>yes</code>, return the number of nodes matched by <em>xpath</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>fragment</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The string representation of the XML fragment expected at xpath.  Since ansible 2.9 not required when <em>state=absent</em>, or when <em>count=yes</em>.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: xmlstring</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>path</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Path to the file to operate on.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: dest, file</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>state</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>present</b>&nbsp;&larr;</div></li>
                                    <li>absent</li>
                        </ul>
                </td>
                <td>
                        <div>Set or remove the nodes (or attributes) matched by <em>xpath</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>type</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>attribute</li>
                                    <li><div style="color: blue"><b>element</b>&nbsp;&larr;</div></li>
                                    <li>text</li>
                        </ul>
                </td>
                <td>
                        <div>The type of XML node you are working with.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>xpath</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Xpath to select the node or nodes to operate on.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - Only supports operating on xml elements, attributes and text.
   - Namespace, processing-instruction, command and document node types cannot be modified with this module.


See Also
--------

.. seealso::

   :ref:`community.general.xml_module`
       XML manipulation for Posix hosts.
   `w3shools XPath tutorial <https://www.w3schools.com/xml/xpath_intro.asp>`_
       A useful tutorial on XPath


Examples
--------

.. code-block:: yaml

    - name: Apply our filter to Tomcat web.xml
      community.windows.win_xml:
       path: C:\apache-tomcat\webapps\myapp\WEB-INF\web.xml
       fragment: '<filter><filter-name>MyFilter</filter-name><filter-class>com.example.MyFilter</filter-class></filter>'
       xpath: '/*'

    - name: Apply sslEnabledProtocols to Tomcat's server.xml
      community.windows.win_xml:
       path: C:\Tomcat\conf\server.xml
       xpath: '//Server/Service[@name="Catalina"]/Connector[@port="9443"]'
       attribute: 'sslEnabledProtocols'
       fragment: 'TLSv1,TLSv1.1,TLSv1.2'
       type: attribute

    - name: remove debug configuration nodes from nlog.conf
      community.windows.win_xml:
       path: C:\IISApplication\nlog.conf
       xpath: /nlog/rules/logger[@name="debug"]/descendant::*
       state: absent

    - name: count configured connectors in Tomcat's server.xml
      community.windows.win_xml:
       path: C:\Tomcat\conf\server.xml
       xpath: //Server/Service/Connector
       count: yes
      register: connector_count

    - name: show connector count
      debug:
        msg="Connector count is {{connector_count.count}}"

    - name: ensure all lang=en attributes to lang=nl
      community.windows.win_xml:
       path: C:\Data\Books.xml
       xpath: //@[lang="en"]
       attribute: lang
       fragment: nl
       type: attribute



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
                    <b>backup_file</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>if backup=yes</td>
                <td>
                            <div>Name of the backup file that was created.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">C:\Path\To\File.txt.11540.20150212-220915.bak</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>count</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>if count=yes</td>
                <td>
                            <div>Number of nodes matched by xpath.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">33</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>err</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                    </div>
                </td>
                <td>always, for type element and -vvv or more</td>
                <td>
                            <div>XML comparison exceptions.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">attribute mismatch for actual=string</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>msg</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>What was done.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">xml added</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Richard Levenberg (@richardcs)
- Jon Hawkesworth (@jhawkesworth)
