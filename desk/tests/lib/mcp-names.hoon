/+  *test, mn=mcp-names
|%
++  test-hyphen-segments
  ;:  weld
    (expect-eq !>(/mcp/commit-desk) !>((tool-name-path:mn 'mcp-commit-desk')))
    (expect-eq !>(/aqua/start) !>((tool-name-path:mn 'aqua/start')))
    (expect-eq !>(/dojo) !>((tool-name-path:mn 'dojo')))
  ==
++  test-prefix-match
  ;:  weld
    (expect-eq !>(&) !>((tool-under-path:mn 'mcp-commit-desk' /mcp)))
    (expect-eq !>(&) !>((tool-under-path:mn 'mcp-commit-desk' /mcp/commit-desk)))
    (expect-eq !>(|) !>((tool-under-path:mn 'mcp-commit-desk' /dojo)))
    (expect-eq !>(|) !>((tool-under-path:mn 'mcp-commit-desk' /mcp/commit)))
    (expect-eq !>(&) !>((tool-under-path:mn 'dojo/command' /dojo)))
  ==
--
