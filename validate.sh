#!/bin/bash
bundle exec brakeman -z -q -o /dev/null && ./rubocop.sh && bundle exec rspec
