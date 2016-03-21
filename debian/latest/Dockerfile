FROM debian:jessie
MAINTAINER Binh Le <lebinh.it@gmail.com>

ENV NGINX_VERSION=1.8.1 \
    LUAJIT_VERSION=2.0.4 \
    LUAJIT_MAJOR_VERSION=2.0 \
    NGINX_DEVEL_KIT_VERSION=0.2.19 \
    LUA_NGINX_MODULE_VERSION=0.9.20 \
    NGINX_INSTALL_PATH=/opt/nginx

# build nginx
COPY build-nginx.sh /opt/
RUN /opt/build-nginx.sh

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /opt/nginx/logs/access.log \
    && ln -sf /dev/stderr /opt/nginx/logs/error.log

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
