#!/bin/bash
#
# Drupal install method:
# Git clone and run a local environment with PHP and SQLite.
# Based on: https://www.drupal.org/project/drupal/issues/2911319
#
# Prerequisites:
#   - Install PHP and Composer.

# Variables.
CURRENT_PATCH="https://www.drupal.org/files/issues/2018-03-24/2911319-171.patch"
INSTALL_PROFILE="standard"

# Clone Drupal.
git clone --branch 8.6.x https://git.drupal.org/project/drupal.git drupal-core
cd drupal-core

# Apply the current patch from issue #2911319.
curl $CURRENT_PATCH | git apply -v

# Install dependencies with Composer.
composer install

# Run the site using a local PHP environment.
php core/scripts/drupal quick-start standard

# TODO: Test that the environment responds to a request?
# TODO: Kill quick-start with Ctrl-C automatically?
