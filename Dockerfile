# syntax = docker/dockerfile:1

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t my-app .
# docker run -d -p 80:80 -p 443:443 --name my-app -e RAILS_MASTER_KEY=<value from config/master.key> my-app

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.3.5
FROM docker.io/library/ruby:$RUBY_VERSION-alpine AS base

# Install base packages
RUN apk update \
&&  apk upgrade \
&&  apk add --no-cache --update \ 
    alpine-sdk curl git jemalloc libpq-dev nodejs openssl pkgconf sqlite vips \
&&  apk cache clean \
&&  rm -rf /var/cache/apk/*

# https://thriveread.com/sqlite-docker-container-and-docker-compose/
# Create a directory to store the database
# WORKDIR /db
# Copy your SQLite database file into the container
# COPY initial-db.sqlite3 /db/
# Expose the port if needed
# EXPOSE 1433
# Command to run when the container starts
# CMD ["sqlite3", "/db/initial-db.sqlite3"]

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# Throw-away build stage to reduce size of final image
FROM base AS prebuild

# Install packages needed to build gems
# RUN apt-get update -qq \
#     && apt-get install --no-install-recommends -y  \
#     && apt-get clean \
#     && rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install application gems


# Rails app lives here
WORKDIR /rails

COPY . .
RUN bundle install \
&&  rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git \
&&  bundle exec bootsnap precompile --gemfile \
#
# Copy application code
# COPY . .
#
# Precompile bootsnap code for faster boot times
&&  bundle exec bootsnap precompile app/ lib/ \
#
# Adjust binfiles to be executable on Linux
&&  chmod +x bin/* && \
    sed -i "s/\r$//g" bin/* && \
    sed -i 's/ruby\.exe$/ruby/' bin/* \
#
# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
&&  ./bin/rails assets:precompile  \
&&  ./bin/rails db:migrate

# Final stage for app image
FROM prebuild AS build

# Copy built artifacts: gems, application
COPY --from=prebuild "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=prebuild /rails /rails

# Run and own only the runtime files as a non-root user for security
RUN addgroup -S -g 1000 rails \
&&  adduser rails -D -u 1000 -G rails -s /bin/bash \
&&  chown -R rails:rails db log storage tmp \
&&  chmod +x /rails/bin/docker-entrypoint
USER 1000:1000

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["/rails/bin/rails", "server"]
