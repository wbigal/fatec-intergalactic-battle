#!/bin/bash
brakeman -z -q -o /dev/null && ./rubocop.sh && rspec
