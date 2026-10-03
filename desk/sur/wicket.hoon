::  /sur/wicket: types for the %wicket authorization server
::
::    A wicket is a small door in a larger gate: Earth MCP clients enter
::    here; they do not own the ship. Resource desks copy this file.
::
|%
+$  scope     @t            ::  "recipe.read" — cords, not nested terms
+$  resource  @t            ::  absolute URL https://host/mcp/recipe
+$  client-id  @t
::
::  Consent text supplied by a resource server. An empty title or
::  label falls back to the URL or the scope cord. warn=? scopes
::  are opt-in on the consent page.
::
+$  scope-note
  $:  label=@t
      warn=?
  ==
+$  scope-copy
  $:  title=@t
      notes=(map scope scope-note)
  ==
::
+$  client
  $:  id=client-id
      name=@t
      redirect-uris=(set @t)
      created=@da
  ==
::
+$  registered-resource
  $:  url=resource
      agent=term
      scopes=(set scope)
      audience=@t
  ==
::
+$  authz
  $:  id=@uv
      client=client-id
      redirect=@t
      state=@t
      challenge=@t
      resource=(unit resource)
      scopes=(list scope)
      expires=@da
  ==
::
+$  code
  $:  id=@t
      client=client-id
      redirect=@t
      challenge=@t
      resource=(unit resource)
      scopes=(list scope)
      expires=@da
      used=?
  ==
::
+$  access
  $:  id=@t                 ::  opaque token string (also map key)
      client=client-id
      resource=(unit resource)
      scopes=(list scope)
      expires=@da
  ==
::
+$  refresh
  $:  id=@t
      client=client-id
      resource=(unit resource)
      scopes=(list scope)
      expires=@da
  ==
::
+$  grant
  $:  client=client-id
      resource=(unit resource)
      scopes=(list scope)
      expires=@da
  ==
::
+$  authorization
  $:  client=client-id
      resource=(unit resource)
      scopes=(list scope)
      updated=@da
  ==
::
+$  token-info
  $:  id=@t                 ::  full secret; JSON APIs send only id-prefix
      id-prefix=@t
      client=client-id
      resource=(unit resource)
      scopes=(list scope)
      expires=@da
  ==
::
+$  action
  $%  [%set-origin url=@t]     ::  public origin; becomes JSON "issuer"
      [%set-registration open=?]
      [%deny-address =address:eyre]
      [%allow-address =address:eyre]
      [%register-resource =registered-resource]
      [%set-scope-copy url=resource =scope-copy]
      [%unregister-resource url=resource]
      [%revoke-client id=client-id]
      [%revoke-access id=@t]
      [%revoke-refresh id=@t]
      $:  %drop-scopes
          client=client-id
          resource=(unit resource)
          scopes=(list scope)
      ==
  ==
--
