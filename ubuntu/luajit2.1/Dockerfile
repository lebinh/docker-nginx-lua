FROM ubuntu:14.04
MAINTAINER Binh Le <lebinh.it@gmail.com>

ENV NGINX_VERSION=1.8.1 \
    LUAJIT_VERSION=2.1.0-beta2 \
    LUAJIT_MAJOR_VERSION=2.1 \
    NGINX_DEVEL_KIT_VERSION=0.2.19 \
    LUA_NGINX_MODULE_VERSION=0.9.20 \
    NGINX_INSTALL_PATH=/opt/nginx

# build nginx
COPY build-nginx.sh /opt/
RUN /opt/build-nginx.sh

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
