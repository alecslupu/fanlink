FROM ruby:2.5.1

ENV MAGICK_HOME=/usr
ENV RAILS_ENV production
ENV BUNDLER_VERSION 2.0.1

COPY . /application
WORKDIR /application
RUN gem update --system \
    && gem install bundler -v 2.0.1

RUN bundle install --jobs=20 --retry=5 --deployment --without development test staging

ENTRYPOINT ./entrypoint.sh
