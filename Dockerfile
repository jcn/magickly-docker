# Building explicitly so we can have ARM support
# https://curiosity-driven.com/articles/building-ruby-2.1/

FROM alpine:3.8

RUN apk --no-cache add \
  bash \
  build-base  \
  git \
  libffi-dev \
  openssl-dev \
  readline-dev \
  yaml-dev \
  zlib-dev \
  file \
  imagemagick

RUN git clone https://github.com/rbenv/ruby-build.git && \
  PREFIX=/usr/local ./ruby-build/install.sh && \
  rm -rf ruby-build && \
  CONFIGURE_OPTS="--disable-install-doc" ruby-build -v 2.1.10 /usr/local

RUN gem install bundler --version 1.17.3 --no-document && \
    gem install puma -v 3.11.0 --no-document

WORKDIR /app

RUN git clone https://github.com/jcn/magickly.git

WORKDIR /app/magickly
RUN bundle config --global frozen 1
RUN bundle install --without development test

COPY ./magickly.ru /app/magickly/magickly.ru

EXPOSE 9292

CMD ["puma", "-t", "1:1", "-e", "production", "/app/magickly/magickly.ru"]
