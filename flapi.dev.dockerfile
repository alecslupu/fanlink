FROM ruby:2.5.1-alpine3.7

ARG BUILD_ENV=production
ARG FOLDER_PATH=./

RUN apk add --no-cache \
          git \
          build-base \
          postgresql-dev \
          nodejs \
          tzdata


COPY ./bin/entrypoint /
COPY ./fanlink-development.json /usr/src/app/
COPY ./flapi.env /usr/src/app/.env

ENV BUNDLE_PATH /gems
ENV BUNDLE_GEMFILE /tmp/Gemfile

RUN chmod +x /start

EXPOSE 3000

WORKDIR /usr/src/app

VOLUME /usr/src/app

CMD ["/entrypoint"]
