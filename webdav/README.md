# WebDAV

Apache httpd 2.4 with `mod_dav`, Basic Auth, content-digest strong ETags, and safe conditional PUT support.

## Start

```sh
cp .env.example .env # first use only; then set username/password
mkdir -p data
docker compose up -d --build --remove-orphans
```

The service remains on host port `6065`. TLS and the public hostname remain at the existing reverse proxy. Data persists in `./data`; WebDAV locks persist in the Docker volume `dav-locks`.

If `./data` belongs to another account, set `WEBDAV_UID` and `WEBDAV_GID` in `.env` to its numeric owner. Do not recursively change existing data ownership just to deploy.

The reverse proxy must pass WebDAV methods and `If-None-Match`, `If-Match`, `If`, `Lock-Token`, `Overwrite`, and `Destination` request headers unchanged. It must not remove `ETag`, `DAV`, or `Lock-Token` response headers.

## Rollback

Stop the service, restore the previous `compose.yaml` and `config.yml` from Git, then run `docker compose up -d`. Normal rollback must not delete or restore `./data`.
