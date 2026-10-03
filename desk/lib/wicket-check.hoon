::  /lib/wicket-check: Bearer check for resource agents
::
::    Parse Authorization: Bearer <token> and scry %wicket.
::    An Eyre request authenticated as our is allowed without a token.
::    %wicket's own OAuth routes do not use this shortcut.
::
::    401 responses should send:
::      WWW-Authenticate: Bearer realm="wicket",
::        resource_metadata="{origin}/wicket/oauth/protected-resource/<resource path>"
::
/-  *wicket
|%
++  header
  |=  [key=@t headers=header-list:http]
  ^-  (unit @t)
  =/  k  (cass (trip key))
  |-  ^-  (unit @t)
  ?~  headers  ~
  ?:  =(k (cass (trip key.i.headers)))
    `value.i.headers
  $(headers t.headers)
::
++  bearer
  |=  headers=header-list:http
  ^-  (unit @t)
  =/  auth  (header 'authorization' headers)
  ?~  auth  ~
  =/  t  (trip u.auth)
  ?.  =((scag 7 (cass t)) "bearer ")  ~
  [~ (crip (slag 7 t))]
::
::  +metadata: PRM URL %wicket serves for a registered resource
::
++  metadata
  |=  [org=@t resource=@t]
  ^-  @t
  =/  n  (met 3 org)
  =/  o=@t
    ?:  ?&  !=(0 n)
            =('/' (cut 3 [(dec n) 1] org))
        ==
      (end [3 (dec n)] org)
    org
  =/  path=@t
    ?:  =(o resource)  ''
    =/  m  (met 3 o)
    ?:  |(=(0 m) (lth (met 3 resource) +(m)))  ''
    ?.  =(o (end [3 m] resource))  ''
    (cut 3 [m (sub (met 3 resource) m)] resource)
  (rap 3 o '/wicket/oauth/protected-resource' path ~)
::
++  ok
  |=  [our=@p now=@da audience=@t scope=@t token=@t]
  ^-  ?
  .^  ?
    %gx
    :~  (scot %p our)
        %wicket
        (scot %da now)
        %ok
        (scot %t audience)
        (scot %t scope)
        (scot %t token)
        %noun
    ==
  ==
::
++  check
  |=  $:  =bowl:gall
          =inbound-request:eyre
          audience=@t
          scope=@t
      ==
  ^-  ?
  ?:  ?&  authenticated.inbound-request
          =(src.bowl our.bowl)
      ==
    %.y
  =/  tok  (bearer header-list.request.inbound-request)
  ?~  tok  %.n
  (ok our.bowl now.bowl audience scope u.tok)
--
