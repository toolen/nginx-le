FROM nginx:1.29-alpine3.23@sha256:8491795299c8e739b7fcc6285d531d9812ce2666e07bd3dd8db00020ad132295

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
