#!/bin/sh
echo "Running database setup"
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed

echo "starting PUMA"
bundle exec puma -C config/puma.rb
