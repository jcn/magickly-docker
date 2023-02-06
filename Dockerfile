FROM ruby:2.1.10-alpine

RUN apk add --no-cache build-base file imagemagick git

RUN gem install puma -v 3.11.0

WORKDIR /app

RUN git clone https://github.com/afeld/magickly.git

WORKDIR /app/magickly
RUN bundle install

EXPOSE 9292

CMD puma -t 1:1 -e production /app/magickly/config.ru

