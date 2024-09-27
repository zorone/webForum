# syntax = docker/dockerfile:1

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t my-app .
# docker run -d -p 80:80 -p 443:443 --name my-app -e RAILS_MASTER_KEY=<value from config/master.key> my-app

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.2.4
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Rails app lives here
WORKDIR /rails

# Install base packages
RUN apt-get update -qq \
&&  apt-get install --no-install-recommends -y \ 
    build-essential curl git libjemalloc2 libpq-dev libvips nodejs pkg-config sqlite3 \
&&  apt-get clean \
&&  rm -rf /var/lib/apt/lists /var/cache/apt/archives

# https://thriveread.com/sqlite-docker-container-and-docker-compose/
# Create a directory to store the database
WORKDIR /db
# Copy your SQLite database file into the container
COPY initial-db.sqlite3 /db/
# Expose the port if needed
# EXPOSE 1433
# Command to run when the container starts
CMD ["sqlite3", "/data/initial-db.sqlite3"]

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
&&  SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile 

# Final stage for app image
FROM prebuild AS build

# Copy built artifacts: gems, application
COPY --from=prebuild "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=prebuild /rails /rails
COPY --from=prebuild /bin /bin

# Run and own only the runtime files as a non-root user for security
RUN groupadd --system --gid 1000 rails \
&&  useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash \
&&  chown -R rails:rails db 
USER 1000:1000

# Entrypoint prepares the database.
ENTRYPOINT ["./bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]