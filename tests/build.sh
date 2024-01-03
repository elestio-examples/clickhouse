#!/usr/bin/env bash
rm -f docker/server/Dockerfile
rm -f docker/server/README.md
cp -rf docker/server/* ./
mv Dockerfile.ubuntu Dockerfile
docker buildx build . --output type=docker,name=elestio4test/clickhouse-server:latest | docker load