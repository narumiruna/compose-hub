#!/bin/sh
set -eu

: "${WEBDAV_USERNAME:?WEBDAV_USERNAME is required}"
: "${WEBDAV_PASSWORD:?WEBDAV_PASSWORD is required}"
WEBDAV_UID="${WEBDAV_UID:-501}"
WEBDAV_GID="${WEBDAV_GID:-20}"

case "$WEBDAV_UID:$WEBDAV_GID" in
  *[!0-9:]*|:*|*:) echo "WEBDAV_UID and WEBDAV_GID must be numeric" >&2; exit 1 ;;
esac
case "$WEBDAV_USERNAME" in
  *:*) echo "WEBDAV_USERNAME must not contain ':'" >&2; exit 1 ;;
esac

group_name="$(getent group "$WEBDAV_GID" | cut -d: -f1 || true)"
if [ -z "$group_name" ]; then
  group_name=webdav
  groupadd --gid "$WEBDAV_GID" "$group_name"
fi
user_name="$(getent passwd "$WEBDAV_UID" | cut -d: -f1 || true)"
if [ -z "$user_name" ]; then
  user_name=webdav
  useradd --uid "$WEBDAV_UID" --gid "$WEBDAV_GID" --no-create-home --shell /usr/sbin/nologin "$user_name"
fi

hash="$(printf '%s' "$WEBDAV_PASSWORD" | openssl passwd -apr1 -stdin)"
printf '%s:%s\n' "$WEBDAV_USERNAME" "$hash" > /run/webdav.htpasswd
chmod 0600 /run/webdav.htpasswd

sed -e "s/__WEBDAV_USER__/$user_name/" -e "s/__WEBDAV_GROUP__/$group_name/" \
  /usr/local/apache2/conf/httpd.conf.template > /usr/local/apache2/conf/httpd.conf
chown "$WEBDAV_UID:$WEBDAV_GID" /run/webdav.htpasswd /var/lib/dav

exec "$@"
