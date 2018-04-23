source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Flexible authentication solution for Rails with Warden.
gem 'devise'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
# RailsAdmin is a Rails engine that provides an easy-to-use interface for
# managing your data
gem 'rails_admin', '~> 1.3'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger
  # console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # A static analysis security vulnerability scanner for RoR applications
  gem 'brakeman', require: false
  # Loads environment variables from `.env`
  gem 'dotenv-rails'
  # Access an interactive console on exception pages or by calling 'console'
  # anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # A Ruby static code analyzer, based on the community Ruby style guide.
  gem 'rubocop', require: false
  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  # Strategies for cleaning databases in Ruby.
  # Can be used to ensure a clean state for testing.
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  # Collection of testing matchers extracted from Shoulda
  gem 'shoulda-matchers', require: false
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  # Code coverage for Ruby 1.9+ with a powerful configuration library and
  #  automatic merging of coverage across test suites
  gem 'simplecov', require: false
end

group :development, :test do
  # Factory Bot S2 Rails
  gem 'factory_bot_rails'
  # RSpec for Rails-3+
  gem 'rspec-rails', '~> 3.7'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
