# SigNoz

Single-node SigNoz with PostgreSQL, ClickHouse, ClickHouse Keeper, and the SigNoz OpenTelemetry Collector. All data uses local `data/` directories. Database ports are not published.

Requires Docker Compose v2 and at least 4 GB of memory allocated to Docker.

## Setup

From this directory, create `.env` once before the first start. Use a hex password so it is valid in the PostgreSQL URI:

```sh
printf 'POSTGRES_PASSWORD=%s\n' "$(openssl rand -hex 32)" > .env
just up
docker compose ps -a
```

Do not replace `.env` after PostgreSQL has initialized. Back up `.env` with the data.

Open http://127.0.0.1:8085 and create the first administrator account. Startup downloads the histogram function from GitHub and runs database migrations. The `init-clickhouse` and `migrator` services should exit with code 0.

| Endpoint | Address |
| --- | --- |
| UI and API | `http://127.0.0.1:8085` |
| OTLP gRPC | `http://127.0.0.1:4317` |
| OTLP HTTP | `http://127.0.0.1:4318` |

All published ports bind to loopback. For remote access, use an SSH tunnel or an authenticated TLS proxy. Containers on this stack's network can send OTLP to `otel-collector:4317` or `otel-collector:4318`.

```sh
docker compose logs -f signoz otel-collector
just down
```

`just down` preserves `data/`. Stop the stack before backing up `data/`.

## Source and updates

Adapted from the [official Foundry Compose example](https://github.com/SigNoz/foundry/tree/5de989d835fcc665be67a9884ea4087c06115e17/docs/examples/docker/compose). Images are pinned to SigNoz `v0.149.0`, Collector `v0.144.15`, and ClickHouse/Keeper `25.12.5`; PostgreSQL tracks major version `16`.

These files are managed directly with Docker Compose; Foundry is not required. Before an upgrade, review the [official Docker guide](https://signoz.io/docs/install/docker/) and release notes, then update images and matching configuration files together.
