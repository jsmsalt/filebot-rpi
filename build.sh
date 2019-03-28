#!/bin/sh

docker login && \
docker build . -t alpine-filebot-rpi --no-cache && \
docker tag alpine-filebot-rpi jsmsalt/alpine-filebot-rpi:latest && \
docker push jsmsalt/alpine-filebot-rpi:latest
