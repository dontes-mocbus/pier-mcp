::  washed text for failures spider and the tools can actually see.
::  ford's own tanks are slogged as hints and never arrive here.
|%
::  +tang-text: one cord, lines joined by newline, as dojo would wash it
++  tang-text
  |=  =tang
  ^-  @t
  %-  of-wain:format
  %-  zing
  %+  turn  tang
  |=  =tank
  %+  turn  (wash [0 80] tank)
  |=  =tape
  (crip tape)
::
::  +thread-fail-text: spider's %thread-fail fact is [term tang], not a
::  bare tang. an empty tang still names the term (%build-thread-error).
++  thread-fail-text
  |=  [term=@tas =tang]
  ^-  @t
  =/  body=@t  (tang-text tang)
  =/  head=tape  "thread failed: %{(trip term)}"
  ?:  =('' body)
    (crip head)
  (crip "{head}\0a{(trip body)}")
::
::  +peek-path: gall strips the last knot of an %x scry as the wanted
::  mark. keep a knot that is already that mark; otherwise append it.
++  peek-path
  |=  [pax=path want=@tas]
  ^-  path
  ?:  =(~ pax)
    /[want]
  ?:  =(want (rear pax))
    pax
  (snoc pax want)
--
