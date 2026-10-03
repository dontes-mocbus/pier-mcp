/+  *test, tr=mcp-trace
|%
++  test-tang-text-keeps-leaf
  =/  got=(each * tang)  (mule |.(~|(%nest-fail !!)))
  ?>  ?=(%| -.got)
  =/  text=tape  (trip (tang-text:tr p.got))
  (expect-eq !>(&) !>(!=(~ (find "nest-fail" text))))
::
++  test-thread-fail-text
  =/  msg=@t  (thread-fail-text:tr %poke-fail ~[[%leaf "nest-fail"]])
  =/  bare=@t  (thread-fail-text:tr %build-thread-error ~)
  ;:  weld
    (expect-eq !>(&) !>(!=(~ (find "poke-fail" (trip msg)))))
    (expect-eq !>(&) !>(!=(~ (find "nest-fail" (trip msg)))))
    (expect-eq !>('thread failed: %build-thread-error') !>(bare))
  ==
::
++  test-peek-path
  ;:  weld
    (expect-eq !>(`path`/origin/noun) !>((peek-path:tr /origin %noun)))
    (expect-eq !>(`path`/tools/json) !>((peek-path:tr /tools/json %json)))
    (expect-eq !>(`path`/resources/noun) !>((peek-path:tr /resources %noun)))
  ==
--
