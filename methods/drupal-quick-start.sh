#!/bin/bash
#
# Drupal install method:
# Git clone and run a local environment with PHP and SQLite.
# Based on: https://www.drupal.org/project/drupal/issues/2911319
#
# Prerequisites:
#   - Install PHP and Composer.

# Variables.
CURRENT_PATCH="https://www.drupal.org/files/issues/2018-04-11/2911319-2-200_0.patch"
INSTALL_PROFILE="standard"

# Download and expand Drupal.
curl -O https://ftp-origin.drupal.org/files/projects/drupal-8.6.x-dev.zip
unzip -q drupal-8.6.x-dev.zip && rm drupal-8.6.x-dev.zip && mv drupal-8.6.x-dev drupal-quick-start
cd drupal-quick-start

# Apply the current patch from issue #2911319.
git init
curl $CURRENT_PATCH | git apply -v

# Run the site using a local PHP environment.
php core/scripts/drupal quick-start standard --suppress-login --port 8888 &
# Wait 2 minutes for Drupal installation to complete.
sleep 120

# Test that the environment responds to a request.
curl -s http://localhost:8888/

# TODO: Kill backgrounded quick-start?
