FROM ruby:2.5.1-alpine3.7

ARG BUILD_ENV=production
ARG FIREBASE_JSON_FILE_PATH=./


RUN apk add --no-cache \
          git \
          build-base \
          postgresql-dev \
          nodejs \
          tzdata


COPY ${FIREBASE_JSON_FILE_PATH}/fanlink-${BUILD_ENV}.json /usr/src/app/

ENV BUNDLE_PATH /gems
ENV BUNDLE_GEMFILE /tmp/Gemfile

RUN chmod +x /start

EXPOSE 3000

WORKDIR /usr/src/app

VOLUME /usr/src/app

CMD ["/bin/entrypoint"]
