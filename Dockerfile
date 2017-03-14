FROM alpine:3.5

MAINTAINER Gyula Voros <gyula@makery.co>

ARG features=

RUN apk add --update ca-certificates

RUN apk add --no-cache curl tar \
  && curl --silent --show-error --fail --location \
    --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
    "https://caddyserver.com/download/build?os=linux&arch=amd64&features=${features}" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
  && chmod 0755 /usr/bin/caddy \
  && /usr/bin/caddy -version \
  && apk del curl tar

EXPOSE 80 443

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/Caddyfile"]
