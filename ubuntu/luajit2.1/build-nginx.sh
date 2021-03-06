#!/usr/bin/env bash
set -ex

mkdir /src
cd /src

NGINX_DEVEL_KIT_PATH=$(pwd)/ngx_devel_kit-${NGINX_DEVEL_KIT_VERSION}
LUA_NGINX_MODULE_PATH=$(pwd)/lua-nginx-module-${LUA_NGINX_MODULE_VERSION}

# install dependencies and build tools
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    libpcre++-dev \
    libssl-dev \
    zlib1g-dev

# download sources
curl -L http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar xz
curl -L http://luajit.org/download/LuaJIT-${LUAJIT_VERSION}.tar.gz | tar xz
curl -L https://github.com/simpl/ngx_devel_kit/archive/v${NGINX_DEVEL_KIT_VERSION}.tar.gz | tar xz
curl -L https://github.com/openresty/lua-nginx-module/archive/v${LUA_NGINX_MODULE_VERSION}.tar.gz | tar xz

# install luajit
(cd LuaJIT-${LUAJIT_VERSION} && make install)
ln -sf luajit-${LUAJIT_VERSION} /usr/local/bin/luajit

# build nginx
cd nginx-${NGINX_VERSION}
export LUAJIT_LIB=/usr/local/lib/lua
export LUAJIT_INC=/usr/local/include/luajit-${LUAJIT_MAJOR_VERSION}
./configure --prefix=${NGINX_INSTALL_PATH} \
            --sbin-path=/usr/sbin/nginx \
            --conf-path=/etc/nginx/nginx.conf \
            --http-log-path=/var/log/nginx/access.log \
            --error-log-path=/var/log/nginx/error.log \
            --pid-path=/run/nginx.pid \
            --with-http_ssl_module \
            --with-ld-opt='-Wl,-rpath,/usr/local/lib/lua' \
            --add-module=${NGINX_DEVEL_KIT_PATH} \
            --add-module=${LUA_NGINX_MODULE_PATH}
make -j2
make install

# forward request and error logs to docker log collector
ln -sf /dev/stdout /var/log/nginx/access.log
ln -sf /dev/stderr /var/log/nginx/error.log

# cleanup to reduce docker image size
apt-get remove -y curl build-essential
apt-get -y autoremove
apt-get clean
rm -rf /src
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
