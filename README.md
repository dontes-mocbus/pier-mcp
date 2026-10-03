# %pier-mcp

MCP server for an Urbit pier. The tools match [urbit-mcp](https://github.com/gwbtc/urbit-mcp) (hyphenated names). This desk is derived from that project, which is MIT licensed, Copyright (c) 2025 Groundwire. Authorization is [wicket](https://github.com/gwbtc/wicket): the client is given the URL and the ship owner approves scopes in the browser. No `urbauth` cookie.

The desk is `%pier-mcp`, the agent is `%pier-mcp`, and the endpoint is `/pier-mcp`. It can run beside `%mcp-server` on `/mcp`.

Kelvin `[%zuse 409]` and `[%zuse 408]`.

## Install

`%wicket` must already be running and its origin set.

```
|new-desk %pier-mcp
|mount %pier-mcp
```

```
zig build -Ddesk=~/path/to/pier/pier-mcp
```

```
|commit %pier-mcp
|install our %pier-mcp
```

The agent registers `{origin}/pier-mcp` with `%wicket` and sends consent text. On the approval page, **Full control of this ship** starts unchecked.

## Scopes

| Scope | What it allows |
| --- | --- |
| `pier-mcp.read` | Identity, Clay reads, scries, and compiling a file |
| `pier-mcp.files` | Insert, commit, mount, and create desks. Does not run what it writes |
| `pier-mcp.aqua` | Virtual ships in `%aqua`, including loading a pill |
| `pier-mcp.owner` | Dojo, pokes, threads, install, nuke, revive, permissions, tests, pills on Unix, and adding MCP tools. A tool added here runs as the ship |

`tools/list` shows only the scopes on the token. Calling a hidden tool is HTTP 403 and names the missing scope.

Grok Build, with no cookie:

```toml
[mcp_servers.pier-mcp]
url = "http://127.0.0.1:8080/pier-mcp"
enabled = true
```

`/mcps`, refresh, then authenticate `pier-mcp`.
