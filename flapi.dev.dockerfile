FROM ruby:2.5.1-alpine3.7

ARG BUILD_ENV=production
ARG FIREBASE_JSON_FILE_PATH=./


RUN apk add --no-cache \
          git \
          build-base \
          postgresql-dev \
          nodejs \
          tzdata \
          imagemagick \
          file


RUN npm config set unsafe-perm true && npm install -g newman leasot auto-changelog redoc-cli

ENV BUNDLE_PATH /gems

COPY ./bin/entrypoint /entrypoint
COPY ./bin/entrypoint_queue /entrypoint_queue
COPY ./ /usr/src/app/

RUN chmod +x /entrypoint
RUN chmod +x /entrypoint_queue

EXPOSE 3000

WORKDIR /usr/src/app

VOLUME /usr/src/app

CMD ["/entrypoint"]
