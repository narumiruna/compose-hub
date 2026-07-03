# autossh-proxy

Mounts `~/.ssh` read-only and uses the `proxy` host from your SSH config.

```sh
docker compose up -d --build
docker compose logs -f proxy
```

SOCKS5 listens on `127.0.0.1:22000`. If your host UID is not `1000`, start it with `PUID=$(id -u) docker compose up -d --build`.
