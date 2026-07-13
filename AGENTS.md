# Repository Guidelines

## Avoid Port Conflicts

Before assigning or changing a host port in any `compose.yaml`, check both active listeners and ports reserved by this repository:

1. **Check active listeners.**

   ```shell
   listenr
   ```

   Treat the values in the `PORT` column as occupied. Use the `PROCESS` and `DOCKER` columns to identify what owns each port.

2. **Check every Compose file.**

   ```shell
   rg -n -A 2 '^\s+(ports:|network_mode:\s*host|LISTEN:)' --glob 'compose.yaml' .
   ```

   For a `HOST_PORT:CONTAINER_PORT` mapping, compare the left-hand host port. For a service using `network_mode: host`, inspect its listen-port configuration, such as `LISTEN`.

3. **Choose a port absent from both checks.** `listenr` only reports currently active listeners, so a port assigned to a stopped Compose service may not appear in its output.
