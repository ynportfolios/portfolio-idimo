FROM ruby:2.5
RUN apt-get update
RUN apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  postgresql-client \
  yarn

WORKDIR /portfolio-idimo
COPY Gemfile Gemfile.lock /portfolio-idimo/
RUN bundle install