FROM ruby:2.1.10

RUN apt-get update
RUN apt-get install -y imagemagick libgmp3-dev

RUN gem install puma

WORKDIR /app

RUN git clone https://github.com/afeld/magickly.git

WORKDIR /app/magickly
RUN bundle install

EXPOSE 9292

CMD puma -t 1:1 -e production /app/magickly/config.ru

