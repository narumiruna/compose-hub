FROM httpd:2.4.66-trixie@sha256:89a0b59e6d7285f00fc8df952a1579c31eb035cbdccb96690051e8bb6432cbea

COPY apache/httpd.conf.template /usr/local/apache2/conf/httpd.conf.template
COPY apache/entrypoint.sh /usr/local/bin/webdav-entrypoint
RUN chmod 0755 /usr/local/bin/webdav-entrypoint && mkdir -p /var/lib/dav

ENTRYPOINT ["/usr/local/bin/webdav-entrypoint"]
CMD ["httpd-foreground"]
