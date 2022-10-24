#!/usr/bin/env bash

docker stop p1-search-web
docker stop p1-search-app
docker rm p1-search-web
docker rm p1-search-app
docker network rm p1-search-net
docker volume rm p1-search-data

docker build -t p1-search .
docker network create p1-search-net
docker volume create p1-search-data

docker run --detach --restart=always --volume=src:/src --net=p1-search-net --name=p1-search-app p1-search

docker run --detach --restart=always --volume=src:/src --net=p1-search-net --name=p1-search-web --env=APP_USERNAME="user" --publish=8080:8080 p1-search
