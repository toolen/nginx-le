FROM nginx:1.30.2-alpine3.23@sha256:5c2df657831d8110a6f1dc333b33831c87abedf393658afa579edd28f8becf2b

# enables automatic changelog generation by tools like Dependabot
LABEL org.opencontainers.image.source="https://github.com/toolen/nginx-le"

ADD conf/nginx.conf /etc/nginx/nginx.conf

ADD script/entrypoint.sh /entrypoint.sh
ADD script/le.sh /le.sh

RUN \
 rm /etc/nginx/conf.d/default.conf && \
 chmod +x /entrypoint.sh && \
 chmod +x /le.sh && \
 apk add --no-cache --update certbot tzdata openssl busybox

CMD ["/entrypoint.sh"]
