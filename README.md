# docker-nginx-lua
Docker build for Nginx with Lua module

```
.
├── debian
│   └── stock              # latest, debian-stock - using Debian stock Nginx package, which uses Luajit 2.0
│       ├── Dockerfile
│       └── build.sh
└── ubuntu
    ├── luajit             # ubuntu-luajit - build Nginx from source with Luajit 2.0
    │   ├── Dockerfile
    │   ├── build-nginx.sh
    │   └── build.sh
    ├── luajit2.1          # ubuntu-luajit2.1 - build Nginx from source with Luajit 2.0
    │   ├── Dockerfile
    │   ├── build-nginx.sh
    │   └── build.sh
    └── stock              # ubuntu-stock - using Ubuntu stock Nginx package, which uses Lua 5.1
        ├── Dockerfile
        └── build.sh
```
