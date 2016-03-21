# docker-nginx-lua
Docker build for Nginx with Lua module

```
├── debian
│   └── stock                 # debian-stock - using stock nginx-extras of Debian, which uses Luajit 2.0
│       ├── Dockerfile
│       └── build.sh
└── ubuntu
    ├── luajit                # ubuntu-luajit - build Nginx from source with latest Luajit 2.0 and Lua module
    │   ├── Dockerfile
    │   ├── build-nginx.sh
    │   └── build.sh
    └── stock                 # ubuntu-stock - using stock nginx-extras of Ubuntu, which uses Lua 5.0
        ├── Dockerfile
        └── build.sh
```
