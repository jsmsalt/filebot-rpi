#!/bin/sh

docker login && \
docker build . -t filebot-rpi --no-cache && \
docker tag filebot-rpi jsmsalt/filebot-rpi:latest && \
docker push jsmsalt/filebot-rpi:latest