::  Which scope each built-in tool requires. A name that is not listed
::  is a tool added at runtime and requires pier-mcp.owner.
::
/-  wicket
|%
++  read   %'pier-mcp.read'
++  files  %'pier-mcp.files'
++  aqua   %'pier-mcp.aqua'
++  owner  %'pier-mcp.owner'
::
++  all
  ^-  (list scope:wicket)
  ~[read files aqua owner]
::
++  of-name
  |=  name=@t
  ^-  (unit scope:wicket)
  ?+  name  ~
    %'mcp-get-our-id'            `read
    %'mcp-get-file'              `read
    %'mcp-list-files'            `read
    %'mcp-scry-agent'            `read
    %'mcp-test-build'            `read
    %'mcp-insert-file'           `files
    %'mcp-commit-desk'           `files
    %'dojo-mount-desk'           `files
    %'dojo-new-desk'             `files
    %'aqua-start'                `aqua
    %'aqua-read'                 `aqua
    %'aqua-cancel'               `aqua
    %'aqua-release'              `aqua
    %'aqua-pill'                 `aqua
    %'dojo-command'              `owner
    %'dojo-close'                `owner
    %'dojo-exit'                 `owner
    %'dojo-run-thread'           `owner
    %'dojo-nuke-agent'           `owner
    %'dojo-revive-desk'          `owner
    %'dojo-build-pill'           `owner
    %'mcp-poke-our-agent'        `owner
    %'mcp-install-app'           `owner
    %'mcp-toggle-permissions'    `owner
    %'mcp-run-tests'             `owner
    %'mcp-add-mcp-tool'          `owner
    %'mcp-add-mcp-prompt'        `owner
    %'mcp-add-mcp-resource'      `owner
    %'mcp-add-mcp-template'      `owner
    %'mcp-import-mcp-tools'      `owner
    %'mcp-import-mcp-prompts'    `owner
    %'mcp-import-mcp-resources'  `owner
    %'mcp-import-mcp-templates'  `owner
  ==
::
++  required
  |=  name=@t
  ^-  scope:wicket
  (fall (of-name name) owner)
::
++  copy
  ^-  scope-copy:wicket
  :-  'Pier MCP'
  %-  malt
  ^-  (list [scope:wicket scope-note:wicket])
  :~  :-  read
      ['Read this ship: files, scries, and identity. Cannot change the ship.' %.n]
      :-  files
      ['Write files and create or commit desks. Can plant source. Cannot run it.' %.n]
      :-  aqua
      ['Run virtual ships in %aqua, including building and loading a pill.' %.n]
      :-  owner
      ['Full control of this ship. Dojo, pokes, install, kill, publish desks, shut down, and add MCP tools. A tool added here runs as the ship and is not limited to the other scopes.' %.y]
  ==
--
