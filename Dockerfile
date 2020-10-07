FROM ruby:2.7.2-slim-buster

ENV RAILS_VERSION=6.0.3.3

# Upgrade packages and install dependencies(imagemagick)
RUN apt-get update -yqq && apt-get upgrade -yqq && apt-get -yqq --no-install-recommends \
  install build-essential curl git gnupg2 imagemagick patch liblzma-dev

# Install PostgreSQL Client
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
  apt-get update && apt-get install -yqq postgresql-client-12 libpq-dev --no-install-recommends

# Install Rails
RUN gem install rails -v ${RAILS_VERSION}

WORKDIR /poprobuy-web

COPY Gemfile Gemfile.lock /poprobuy-web/

RUN bundle check || bundle install

COPY . /poprobuy-web/

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
