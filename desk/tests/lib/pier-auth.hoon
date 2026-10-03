::  Discovery header for a missing bearer.
::
/+  *test, pa=pier-auth
|%
++  test-audience
  %+  expect-eq
    !>(`@t`'http://127.0.0.1:8080/pier-mcp')
    !>((audience:pa 'http://127.0.0.1:8080'))
::
++  test-metadata
  %+  expect-eq
    !>(`@t`'http://127.0.0.1:8080/wicket/oauth/protected-resource/pier-mcp')
    !>((metadata:pa 'http://127.0.0.1:8080'))
::
++  test-www-authenticate
  =/  meta  (metadata:pa 'http://127.0.0.1:8080')
  =/  bare  (www-authenticate:pa meta ~)
  =/  scoped  (www-authenticate:pa meta `'pier-mcp.owner')
  ;:  weld
    (expect !>(?=(^ (find "realm=\"wicket\"" (trip bare)))))
    (expect !>(?=(^ (find "protected-resource/pier-mcp" (trip bare)))))
    (expect !>(?=(~ (find "scope=" (trip bare)))))
    (expect !>(?=(^ (find "scope=\"pier-mcp.owner\"" (trip scoped)))))
  ==
--
