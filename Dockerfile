FROM alpine:3.10.2

LABEL maintainer="Shubham Patel <shubhampatelsp812@gmail.com>"

ENV NGINX_VERSION 1.17.4
    
COPY ./configs/ngx_http_header_filter_module.c /tmp/ngx_http_header_filter_module.c
COPY ./configs/nginx.h /tmp/nginx.h

RUN apk update \
    && apk add --no-cache wget build-base openssl-dev pcre-dev zlib-dev\
    && cd /etc \
    && wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
    && tar zxf nginx-${NGINX_VERSION}.tar.gz \
    && rm nginx-${NGINX_VERSION}.tar.gz \
    && set -x \
# create nginx user/group first, to be consistent throughout docker variants
    && addgroup -g 101 -S nginx \
    && adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx \
    && cd /etc/nginx-${NGINX_VERSION} \
    && cp /tmp/ngx_http_header_filter_module.c /etc/nginx-${NGINX_VERSION}/src/http/ngx_http_header_filter_module.c \
    && cp /tmp/nginx.h /etc/nginx-${NGINX_VERSION}/src/core/nginx.h \
    && ./configure \
        --sbin-path=/usr/sbin/nginx \ 
        --user=nginx \
        --group=nginx \
        --with-http_ssl_module \
        --prefix=/etc/nginx \
        --modules-path=/usr/lib/nginx/modules \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --pid-path=/var/run/nginx.pid \
        --lock-path=/var/lock/nginx.lock \
    && make \
    && make install \
    && cd .. \
    && rm -rf /tmp/* \
    && rm -r nginx-${NGINX_VERSION} \
    && apk del build-base openssl-dev zlib-dev wget \
    && rm -rf /var/cache/apk/* \
    && mkdir /etc/nginx/conf.d

COPY configs/nginx.conf /etc/nginx/nginx.conf
CMD ["nginx", "-g", "daemon off;"]