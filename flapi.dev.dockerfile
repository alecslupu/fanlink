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

COPY $PWD/ /usr/src/app/

RUN chmod +x /usr/src/app/bin/*
# RUN chmod +x /usr/src/app/bin/entrypoint_queue

EXPOSE 3000

WORKDIR /usr/src/app

# RUN bundle install

VOLUME /usr/src/app

CMD ["bin/entrypoint"]
