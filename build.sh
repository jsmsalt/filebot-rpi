#!/bin/sh

DOCKERHUB_USERNAME=jsmsalt
IMAGE_NAME=filebot-rpi
IMAGE_TAG=latest

if [ "$1" = "push" ]; then
	docker login && \
	docker push "$DOCKERHUB_USERNAME/$IMAGE_NAME:$IMAGE_TAG"
else
	docker build . -t "$IMAGE_NAME" && \
	docker tag "$IMAGE_NAME" "$DOCKERHUB_USERNAME/$IMAGE_NAME:$IMAGE_TAG"
fi