/-  mcp, spider
/+  io=strandio, libstrand=strand, tr=mcp-trace
=,  strand=strand:libstrand
=>
|%
::  +poke-wait: the nack tang is the result, not a strand failure.
::  a strand %fail becomes spider's %thread-fail, and khan crashes
::  unpacking that fact, so the caller would only see http 500.
++  poke-wait
  |=  [app=term =cage]
  =/  m  (strand:spider ,(each ~ tang))
  ^-  form:m
  ;<  our=@p  bind:m  get-our:io
  ;<  ~  bind:m
    (send-raw-card:io [%pass /poke %agent [our app] %poke cage])
  |=  tin=strand-input:strand
  ?+  in.tin  `[%skip ~]
      ~  `[%wait ~]
      [~ %agent * %poke-ack *]
    ?.  =(/poke wire.u.in.tin)
      `[%skip ~]
    ?~  p.sign.u.in.tin
      `[%done %& ~]
    `[%done %| u.p.sign.u.in.tin]
  ==
--
::
^-  tool:mcp
:*  'mcp-poke-our-agent'
  '''
  Poke a Gall agent with data of a specified mark.
  A noun that does not match the mark, or a poke the agent nacks,
  comes back as the washed tang. The request itself does not crash.
  '''
  %-  my
  :~  :-  'agent'
      :-  %string
      '''
      The name of the Gall agent to poke (e.g. 'hood').
      '''
  ::
      :-  'mark'
      :-  %string
      '''
      The mark of the poke (e.g. 'helm-pass').
      '''
  ::
      :-  'data'
      :-  %string
      '''
      Hoon expression of the type expected for this poke.
      '''
  ==
  ~['agent' 'mark' 'data']
  ^-  thread-builder:tool:mcp
  |=  args=(map name:parameter:tool:mcp argument:tool:mcp)
  ^-  shed:khan
  =/  m  (strand:spider ,vase)
  ^-  form:m
  =/  ant=(unit argument:tool:mcp)  (~(get by args) 'agent')
  =/  mar=(unit argument:tool:mcp)  (~(get by args) 'mark')
  =/  dat=(unit argument:tool:mcp)  (~(get by args) 'data')
  ?~  ant  (pure:m !>([%error %missing-agent ~]))
  ?~  mar  (pure:m !>([%error %missing-mark ~]))
  ?~  dat  (pure:m !>([%error %missing-data ~]))
  ?>  ?=([%string *] u.ant)
  ?>  ?=([%string *] u.mar)
  ?>  ?=([%string *] u.dat)
  ::  ream and slap run while this gate is built, on the http request.
  ::  mule them here so a bad expression is a tool error, not crud!.
  =/  gen=(each vase tang)
    (mule |.((slap !>(..zuse) (ream p.u.dat))))
  ?:  ?=(%| -.gen)
    %-  pure:m
    !>  ^-  response:tool:mcp
    [%error (tang-text:tr p.gen) ~]
  ;<  ack=(each ~ tang)  bind:m
    (poke-wait (@tas p.u.ant) [(@tas p.u.mar) p.gen])
  ?:  ?=(%| -.ack)
    %-  pure:m
    !>  ^-  response:tool:mcp
    [%error (tang-text:tr p.ack) ~]
  %-  pure:m
  !>  ^-  response:tool:mcp
  :-  %result
  :-  %unstructured
  :~  :-  %text
      %-  crip
      "Successfully poked {<(trip p.u.ant)>} with {<(trip p.u.mar)>}"
  ==
==
