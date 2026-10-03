::  Tool-name segments for the prefix scry. The first hyphen is the
::  namespace that used to be a slash: mcp-commit-desk is
::  /mcp/commit-desk, so a later hyphen stays in the tool name.
::  A slash still splits, for a name registered before that change.
::
|%
++  tool-name-path
  |=  name=@t
  ^-  path
  =/  raw=tape  (trip name)
  ?:  ?=(^ (find "/" raw))
    (stab (crip (weld "/" raw)))
  =/  cut=(unit @ud)  (find "-" raw)
  ?~  cut  /(crip raw)
  /(crip (scag u.cut raw))/(crip (slag +(u.cut) raw))
::
++  tool-under-path
  |=  [name=@t prefix=path]
  ^-  ?
  =/  parts=path  (tool-name-path name)
  =(prefix (scag (lent prefix) parts))
--
