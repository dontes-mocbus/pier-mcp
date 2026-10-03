/-  mcp, spider
/+  io=strandio, tr=mcp-trace
=>
|%
++  print-noun
  |=  non=*
  ^-  @t
  %-  of-wain:format
  %+  turn  (wash [0 80] leaf+(render non))
  |=(t=tape (crip t))
::
::  atoms that are printable text are cords, which is how an origin
::  url or a resource path is useful. anything else is dojo's <noun>.
++  render
  |=  non=*
  ^-  tape
  ?:  ?=(@ non)
    ?:  |(=(0 non) (gth (met 3 non) 1.024) !(printable non))
      <non>
    "'{(trip non)}'"
  "[{(render -.non)} {(render +.non)}]"
::
++  printable
  |=  txt=@
  ^-  ?
  (levy (trip txt) |=(c=@ &((gte c 32) (lte c 126))))
--
::
^-  tool:mcp
:*  'mcp-scry-agent'
  '''
  Run a %gx scry (read) against a Gall agent on this ship.
  mark defaults to %json and the result is JSON.
  Pass mark %noun to read a peek that returns a noun, printed the
  way Dojo prints it. Any other mark is requested from Gall and
  printed the same way. %wicket /origin and /resources are nouns.
  '''
  %-  my
  :~  :-  'agent'
      :-  %string
      '''
      The Gall agent to scry.
      '''
      :-  'path'
      :-  %string
      '''
      The peek path (e.g. "/origin" or "/tools"). The mark is
      supplied separately and appended for Gall.
      '''
      :-  'mark'
      :-  %string
      '''
      Mark to request. Defaults to %json. Use %noun for a noun peek.
      '''
  ==
  ~['agent' 'path']
  ^-  thread-builder:tool:mcp
  |=  args=(map name:parameter:tool:mcp argument:tool:mcp)
  ^-  shed:khan
  =/  m  (strand:spider ,vase)
  ^-  form:m
  =/  gen=(unit argument:tool:mcp)  (~(get by args) 'agent')
  ?~  gen  (pure:m !>([%error %missing-agent ~]))
  =/  pax=(unit argument:tool:mcp)  (~(get by args) 'path')
  ?~  pax  (pure:m !>([%error %missing-path ~]))
  ?>  ?=([%string @t] u.gen)
  ?>  ?=([%string @t] u.pax)
  =/  want=@tas
    =/  m=(unit argument:tool:mcp)  (~(get by args) 'mark')
    ?~  m  %json
    ?>  ?=([%string @t] u.m)
    (@tas p.u.m)
  ?.  ((sane %tas) want)
    %-  pure:m
    !>  ^-  response:tool:mcp
    [%error 'mark is not a valid term' ~]
  =/  parsed=(each path tang)
    (mule |.(!<(path (slap !>(.) (ream p.u.pax)))))
  ?:  ?=(%| -.parsed)
    %-  pure:m
    !>  ^-  response:tool:mcp
    [%error (tang-text:tr p.parsed) ~]
  =/  =path  (peek-path:tr p.parsed want)
  ;<  =bowl:spider  bind:m  get-bowl:io
  =/  mule-result=(each * tang)
    %-  mule
    |.
    .^  *
        %gx
        (welp /(scot %p our.bowl)/[p.u.gen]/(scot %da now.bowl) path)
    ==
  ?:  ?=(%| -.mule-result)
    %-  pure:m
    !>  ^-  response:tool:mcp
    [%error (tang-text:tr p.mule-result) ~]
  ?:  =(%json want)
    =/  as-json=(each json tang)
      (mule |.((json p.mule-result)))
    ?:  ?=(%| -.as-json)
      %-  pure:m
      !>  ^-  response:tool:mcp
      [%error (tang-text:tr p.as-json) ~]
    %-  pure:m
    !>  ^-  response:tool:mcp
    :-  %result
    :-  %structured
    %-  frond:enjs:format
    :-  %result
    p.as-json
  %-  pure:m
  !>  ^-  response:tool:mcp
  :-  %result
  :-  %unstructured
  :~  [%text (print-noun p.mule-result)]
  ==
==
