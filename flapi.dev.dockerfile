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

RUN npm install -g apidoc newman

RUN cat ${FIREBASE_JSON_FILE_PATH}/fanlink-${BUILD_ENV}.json > ./fanlink-${BUILD_ENV}.json
COPY ./fanlink-${BUILD_ENV}.json /tmp/

ENV BUNDLE_PATH /gems

COPY ./bin/entrypoint /entrypoint
COPY ./bin/entrypoint_queue /entrypoint_queue

RUN chmod +x /entrypoint
RUN chmod +x /entrypoint_queue

EXPOSE 3000

WORKDIR /usr/src/app

VOLUME /usr/src/app

CMD ["/entrypoint"]
