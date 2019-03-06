#!/bin/bash
# Init empty cache file
if [ ! -f .yarn-cache.tgz ]; then
  echo "Init empty .yarn-cache.tgz"
  tar cvzf .yarn-cache.tgz --files-from /dev/null
fi

docker build . -t portfolio

docker run --rm --entrypoint cat portfolio:latest /portfolio/yarn.lock > /tmp/yarn.docker.lock
if ! diff -q yarn.docker.lock /tmp/yarn.docker.lock > /dev/null  2>&1; then
  echo "Saving Yarn cache"
  docker run --rm --entrypoint tar portfolio:latest czf - /usr/local/share/.cache/yarn/v4/ > .yarn-cache.tgz
  echo "Saving yarn.lock"
  cp /tmp/yarn.docker.lock yarn.docker.lock
fi
