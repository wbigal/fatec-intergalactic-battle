FROM ruby:2.5.0-alpine

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT true

WORKDIR /app
EXPOSE 3000

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle config build.nokogiri --use-system-libraries
RUN apk update && \
    apk add --update --no-cache libxslt-dev build-base g++ gcc libxml2-dev make postgresql-dev tzdata imagemagick file curl nodejs-current
RUN bundle install
RUN apk del build-base g++ gcc libxml2-dev make
RUN rm -r /var/cache/apk/*

COPY . /app/

CMD ["./scripts/web.sh"]
