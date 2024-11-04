FROM ruby:2.7.8-alpine

RUN apk add --no-cache build-base file imagemagick git

RUN gem install puma -v 3.11.0

WORKDIR /app

RUN git clone https://github.com/jcn/magickly.git

WORKDIR /app/magickly
RUN bundle config --global frozen 1
RUN bundle install --without development test

COPY ./magickly.ru /app/magickly/magickly.ru

EXPOSE 9292

CMD ["puma", "-t", "1:1", "-e", "production", "/app/magickly/magickly.ru"]

