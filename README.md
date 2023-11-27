# magickly-docker

Simple Docker setup for [Magickly](https://github.com/afeld/magickly), which is no longer in active development. We mostly use [imgproxy](https://imgproxy.net/) these days, but needed a way to spin up a working Magickly instance.

## Build and Deploy

```bash
$ docker build . -t magickly
$ docker run -p 9292:9292 magickly
```

This Dockerfile also works with [dokku](https://dokku.com/) directly using the Dockerfile deployment.

## Requirements

This Dockerfile is built off of the alpine:3.8 image which should support amd64 and arm64 platforms. We stick with 3.8 because Ruby 2.1.10 won't build on later versions due to OpenSSL issues.
