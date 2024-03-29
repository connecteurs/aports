#!/bin/bash

docker run --rm -P -it \
  -v$(pwd)/${2:-main}:/home/builder/aports \
  --workdir /home/builder/aports/${1:-cyrus-sasl} \
  --name docker-abuild ghcr.io/connecteurs/abuild -r
