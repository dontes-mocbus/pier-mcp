::  The built-in tools partition into the four scopes.
::
/-  wicket
/+  *test, ps=pier-scopes
|%
++  names
  ^-  (list @t)
  :~  'mcp-get-our-id'
      'mcp-get-file'
      'mcp-list-files'
      'mcp-scry-agent'
      'mcp-test-build'
      'mcp-insert-file'
      'mcp-commit-desk'
      'dojo-mount-desk'
      'dojo-new-desk'
      'aqua-start'
      'aqua-read'
      'aqua-cancel'
      'aqua-release'
      'aqua-pill'
      'dojo-command'
      'dojo-close'
      'dojo-exit'
      'dojo-run-thread'
      'dojo-nuke-agent'
      'dojo-revive-desk'
      'dojo-build-pill'
      'mcp-poke-our-agent'
      'mcp-install-app'
      'mcp-toggle-permissions'
      'mcp-run-tests'
      'mcp-add-mcp-tool'
      'mcp-add-mcp-prompt'
      'mcp-add-mcp-resource'
      'mcp-add-mcp-template'
      'mcp-import-mcp-tools'
      'mcp-import-mcp-prompts'
      'mcp-import-mcp-resources'
      'mcp-import-mcp-templates'
  ==
::
++  test-partition
  =/  got  (turn names of-name:ps)
  =/  known  (levy got |=(s=(unit @t) ?=(^ s)))
  =/  dyn  (required:ps 'some-added-tool')
  ;:  weld
    (expect !>(=(33 (lent names))))
    (expect !>(known))
    (expect !>(=(owner:ps dyn)))
    (expect !>(=(read:ps (required:ps 'mcp-get-file'))))
    (expect !>(=(files:ps (required:ps 'mcp-commit-desk'))))
    (expect !>(=(aqua:ps (required:ps 'aqua-pill'))))
    (expect !>(=(owner:ps (required:ps 'dojo-command'))))
    (expect !>(=(owner:ps (required:ps 'mcp-add-mcp-tool'))))
  ==
::
++  test-copy-warns-owner
  ::  title.copy:ps does not resolve; pin the cast so the faces exist.
  =/  cp=scope-copy:wicket  copy:ps
  =/  note  (~(got by notes.cp) owner:ps)
  =/  quiet  (~(got by notes.cp) read:ps)
  ;:  weld
    (expect !>(=(title.cp 'Pier MCP')))
    (expect !>(warn.note))
    (expect !>(!warn.quiet))
  ==
--
