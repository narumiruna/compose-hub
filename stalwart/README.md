# Stalwart

Mail and collaboration server using the official `stalwartlabs/stalwart:v0.16` image and local storage.

## Setup

From this directory, prepare the bind mounts for the container user (UID/GID 2000):

```sh
mkdir -p data/config data/storage
sudo chown -R 2000:2000 data
just up
docker compose logs stalwart
```

Open http://127.0.0.1:8084/admin and use the temporary administrator credentials printed in the logs. For a remote host, use an SSH tunnel to access this loopback-only port.

Complete the setup wizard, select **Console** logging, save the permanent administrator credentials, then run `just restart`. Use `https://<mail-hostname>/admin` after setup.

## Public deployment

- Configure a public mail hostname, MX, SPF, DKIM, DMARC, and PTR records.
- Configure a trusted TLS certificate. Automatic TLS-ALPN-01 validation requires public TCP port 443 to reach Stalwart directly.
- Allow inbound TCP port 25 and ensure outbound TCP port 25 is not blocked.
- Remove port mappings for protocols you do not use.
- If using a reverse proxy, set `STALWART_PUBLIC_URL` in the service environment to the public HTTPS base URL.
- Once HTTPS administration works, disable the HTTP listener through the WebUI.
- Back up both `data/config/` and `data/storage/`.

See the [official Docker guide](https://stalw.art/docs/install/platform/docker/) and [security checklist](https://stalw.art/docs/install/security/).
