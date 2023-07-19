FROM alpine:3.18 as downloader

ENV VERSION 0.9.3

RUN apk update && apk add curl unzip

RUN mkdir /downloads
WORKDIR /downloads

RUN curl -L https://github.com/sabre-io/Baikal/releases/download/$VERSION/baikal-$VERSION.zip -o baikal.zip
RUN unzip baikal.zip -d /baikal


FROM php:8.2.8-fpm-alpine3.18

RUN apk update && apk upgrade && \
    apk add nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY php-fpm.conf /etc/php/php-fpm.conf

RUN mkdir /var/baikal

RUN chown -R nobody:nobody /var/www/html && \
  chown -R nobody:nobody /run && \
  chown -R nobody:nobody /var/lib/nginx && \
  chown -R nobody:nobody /var/log/nginx && \
  chown -R nobody:nobody /var/baikal

USER nobody

COPY --from=downloader --chown=nobody /baikal/baikal /var/www/baikal

WORKDIR /var/www/baikal

COPY docker-entrypoint.sh /docker-entrypoint.sh

COPY start.sh /start.sh

ENTRYPOINT ["/docker-entrypoint.sh"] 

CMD ["/start.sh"]
