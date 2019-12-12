#!/bin/bash
#
# Drupal install method:
# Download Drupal and run a local environment with DDEV Local.
# Based on: http://ddev.readthedocs.io/en/latest/users/cli-usage/#drupal-8-quickstart
#
# Prerequisites:
#   - Install Docker CE.

# Variables.
INSTALL_PROFILE="standard"

# If on Travis CI, update Docker CE.
if [ "$TRAVIS" == "true" ]; then
  echo 'Updating Docker CE in Travis CI environment.'
  source ../tests/docker-latest.sh
fi

# Install DDEV Local.
if ! ddev version ; then
    if [ "$(uname)" == "Darwin" ]; then
        # Install with Homebrew on macOS.
        brew tap drud/ddev && brew install ddev
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        # Install with curl | bash.
        curl https://raw.githubusercontent.com/drud/ddev/master/scripts/install_ddev.sh | bash
    fi
fi

# Download and expand Drupal.
curl -O https://ftp-origin.drupal.org/files/projects/drupal-8.8.x-dev.zip
unzip -q drupal-8.8.x-dev.zip && rm drupal-8.8.x-dev.zip && mv drupal-8.8.x-dev drupal-ddev
cd drupal-ddev

# Configure DDEV.
ddev config --projectname drupal-ddev --projecttype drupal8

# Start DDEV.
ddev start

# Install Drupal.
ddev exec drush si -y $INSTALL_PROFILE --site-name="Drupal DDEV" --db-url=mysql://db:db@db/db

# Test that the environment responds to a request.
curl -s http://drupal-ddev.ddev.local/

# Kill DDEV.
ddev remove
