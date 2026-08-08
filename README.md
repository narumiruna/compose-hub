# Compose Hub

A collection of independent Docker Compose stacks for self-hosted applications and infrastructure.

## Requirements

- Docker with Compose support
- [`just`](https://github.com/casey/just) (optional, but recommended)

## Quick start

Choose a service, review its `compose.yaml`, and create its environment file when a template is provided:

```sh
cd <service>
cp .env.example .env # if .env.example exists
just up
```

Common commands in each service directory:

```sh
just up       # start the stack
just down     # stop the stack
just restart  # restart the stack
```

You can also use `docker compose` directly. Keep secrets in `.env`; local service data and generated files should not be committed.

## Services

- [autossh-proxy](autossh-proxy/)
- [Beszel](beszel/)
- [Bifrost](bifrost/)
- [Cloudflared](cloudflared/)
- [FlareSolverr](flaresolverr/)
- [Hermes](hermes/)
- [Jackett](jackett/)
- [Keycloak](keycloak/)
- [Langfuse](langfuse/)
- [Memos](memos/)
- [Metabase](metabase/)
- [Pocket ID](pocket-id/)
- [Uptime Kuma](uptime-kuma/)
- [WebDAV](webdav/)
- [ZITADEL](zitadel/)
