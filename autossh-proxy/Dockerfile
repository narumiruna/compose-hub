FROM alpine:3

ARG PUID=1000

RUN apk add --no-cache autossh openssh-client \
 && adduser -D -u "$PUID" proxy

USER proxy
ENV HOME=/home/proxy
WORKDIR /home/proxy
CMD ["autossh", "-C", "-N", "-M", "0", "-D", "0.0.0.0:22000", "proxy"]
