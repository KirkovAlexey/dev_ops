FROM ruby:2.6.3
LABEL maintainer="Alexey Kirkov <kirkov.alexey@gmail.com>"

ARG RAILS_ROOT=/app
ARG DEV_PACKAGES="postgresql-client nodejs yarn"
ARG SECRET_KEY

ENV RAILS_ENV=production
ENV NODE_ENV=production
ENV SECRET_KEY_BASE=$SECRET_KEY

WORKDIR $RAILS_ROOT

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt update -qy \
    && apt install -qy $DEV_PACKAGES \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY Gemfile* package.json yarn.lock $RAILS_ROOT/

RUN gem install bundler -v '2.0.1'
RUN bundle config --global frozen 1 \
    && bundle install --without development:test:assets

RUN yarn install --production
COPY ./ $RAILS_ROOT/
RUN cp config/database.yml.sample config/database.yml
RUN bundle exec rails assets:precompile
RUN bundle exec rails webpacker:compile

RUN rm -rf node_modules tmp/cache app/assets vendor/assets spec

CMD rails db:create && rails db:migrate && rails server -b 0.0.0.0
