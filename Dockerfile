FROM nginx:1.26.3-alpine

# enables automatic changelog generation by tools like Dependabot
LABEL org.opencontainers.image.source="https://github.com/toolen/nginx-le"

ADD conf/nginx.conf /etc/nginx/nginx.conf

ADD script/entrypoint.sh /entrypoint.sh
ADD script/le.sh /le.sh

RUN \
 rm /etc/nginx/conf.d/default.conf && \
 chmod +x /entrypoint.sh && \
 chmod +x /le.sh && \
 apk add --no-cache --update certbot tzdata openssl

CMD ["/entrypoint.sh"]
