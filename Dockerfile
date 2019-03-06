FROM node:lts

RUN apt-get update && apt-get install -y \
  apt-utils \
  git \
  apt-utils \
  python-dev

WORKDIR /tmp

RUN git clone https://github.com/facebook/watchman.git && \
  cd watchman && \
  git checkout v4.9.0

WORKDIR /tmp/watchman

RUN ./autogen.sh && \
  ./configure && \
  make && \
  make install

RUN mkdir /portfolio
WORKDIR /portfolio

# yarn can use a pre-existing cache!
# use docker_build.sh to generate this (run it twice the first time you build!)
ADD .yarn-cache.tgz /

COPY ./package.json .
COPY ./cards/asset/package.json ./cards/asset/
COPY ./cards/asset-history/package.json ./cards/asset-history/
COPY ./cards/crypto-compare/package.json ./cards/crypto-compare/
COPY ./cards/network/package.json ./cards/network/
COPY ./cards/portfolio/package.json ./cards/portfolio/
COPY ./cards/register/package.json ./cards/register/
COPY ./cards/transaction/package.json ./cards/transaction/
COPY ./cards/user/package.json ./cards/user/
COPY ./cards/wallet/package.json ./cards/wallet/
COPY ./packages/common/package.json ./packages/common/
COPY ./packages/crypto/package.json ./packages/crypto/
COPY ./packages/utils/package.json ./packages/utils/
COPY ./portfolio/package.json ./portfolio/

COPY ./yarn.docker.lock yarn.lock

RUN yarn install

COPY . /portfolio
