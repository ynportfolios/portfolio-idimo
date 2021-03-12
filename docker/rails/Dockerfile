FROM ruby:2.5

RUN apt-get update
RUN apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  postgresql-client \
  yarn

WORKDIR /app

ADD Gemfile .
ADD Gemfile.lock .
RUN bundle install -j4

ADD . /app

RUN bundle exec rails assets:precompile RAILS_ENV=production SECRET_KEY_BASE=dummy DATABASE_PASSWORD=dummy

EXPOSE 3000

