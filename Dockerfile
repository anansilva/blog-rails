### BASE ###
FROM ruby:2.7.4 as base
RUN curl https://deb.nodesource.com/setup_16.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && \
    apt-get install -qq -y nodejs yarn \
    postgresql-client

RUN mkdir /blog-rails
WORKDIR /blog-rails

COPY Gemfile /blog-rails/Gemfile
COPY Gemfile.lock /blog-rails/Gemfile.lock

RUN bundle install
RUN yarn install

### DEV ###
FROM base as dev
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000
# CMD ["rails", "server", "-b", "0.0.0.0"]

### CI ###
FROM base as ci
COPY .github/config/database.yml config/database.yml

