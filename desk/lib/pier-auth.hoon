::  Bearer admission for %pier-mcp against %wicket.
::
::    An Eyre request authenticated as our is every scope, with no token.
::    Anything else needs a bearer whose grant audience is {origin}/pier-mcp.
::
/-  wicket
/+  wicket-check, ps=pier-scopes
|%
++  audience
  |=  org=@t
  ^-  @t
  (rap 3 org '/pier-mcp' ~)
::
++  metadata
  |=  org=@t
  ^-  @t
  (metadata:wicket-check org (audience org))
::
++  www-authenticate
  |=  [meta=@t scope=(unit @t)]
  ^-  @t
  =/  base=@t
    (rap 3 ['Bearer realm="wicket", resource_metadata="' meta '"' ~])
  ?~  scope  base
  (rap 3 [base ', scope="' u.scope '"' ~])
::
++  json-pay
  |=  [code=@ud jon=json extra=header-list:http]
  ^-  simple-payload:http
  :-  :-  code
      (weld extra ['content-type' 'application/json']~)
  `(as-octt:mimes:html (trip (en:json:html jon)))
::
++  bearer-401
  |=  meta=@t
  ^-  simple-payload:http
  %+  json-pay  401
  :-  (pairs:enjs:format ['error' s+'invalid_token']~)
  ['www-authenticate' (www-authenticate meta ~)]~
::
++  bearer-403
  |=  [meta=@t scope=@t]
  ^-  simple-payload:http
  %+  json-pay  403
  :-  (pairs:enjs:format ['error' s+'insufficient_scope']~)
  ['www-authenticate' (www-authenticate meta `scope)]~
::
++  origin-now
  |=  =bowl:gall
  ^-  (unit @t)
  =/  run
    %-  mule
    |.  .^(@t %gx /(scot %p our.bowl)/wicket/(scot %da now.bowl)/origin/noun)
  ?:  ?=(%| -.run)  ~
  ?:  =('' p.run)  ~
  `p.run
::
++  gx-grant
  |=  [=bowl:gall tok=@t]
  ^-  (unit (unit grant:wicket))
  =/  run
    %-  mule
    |.
    .^  (unit grant:wicket)
      %gx
      /(scot %p our.bowl)/wicket/(scot %da now.bowl)/grant/(scot %t tok)/noun
    ==
  ?:(?=(%| -.run) ~ `p.run)
::
++  admit
  |=  [=bowl:gall req=inbound-request:eyre org=(unit @t)]
  ^-  $%  [%down ~]
          [%no ~]
          [%yes scopes=(list scope:wicket)]
      ==
  ?:  ?&  authenticated.req
          =(src.bowl our.bowl)
      ==
    [%yes all:ps]
  =/  tok  (bearer:wicket-check header-list.request.req)
  ?~  tok  [%no ~]
  ?~  org  [%down ~]
  =/  got  (gx-grant bowl u.tok)
  ?~  got  [%down ~]
  ?~  u.got  [%no ~]
  ?.  =(`(audience u.org) resource.u.u.got)  [%no ~]
  [%yes scopes.u.u.got]
--
