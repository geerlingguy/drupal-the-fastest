#!/bin/bash
#
# Drupal install method:
# Git clone and run a local environment with Lando.
# Based on: https://www.jeffgeerling.com/blog/2018/getting-started-lando-testing-fresh-drupal-8-umami-site
#
# Prerequisites:
#   - Install Git.
#   - Install Docker CE.

# Variables.
INSTALL_PROFILE="standard"
LANDO_VERSION="v3.0.0-beta.40"
LANDO_DMG="https://github.com/lando/lando/releases/download/$LANDO_VERSION/lando-$LANDO_VERSION.dmg"
LANDO_DEB="https://github.com/lando/lando/releases/download/$LANDO_VERSION/lando-$LANDO_VERSION.deb"

# Install Lando.
if ! lando version ; then
    if [ "$(uname)" == "Darwin" ]; then
        # Install with Homebrew on macOS.
        curl $LANDO_DMG -O
        # TODO: Install LandoInstaller.pkg from the DMG.
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        # Install with .deb package.
        curl $LANDO_DEB -O
        sudo dpkg -i $(basename $LANDO_DEB)
    fi
fi

# Download and expand Drupal.
curl https://ftp-origin.drupal.org/files/projects/drupal-8.6.x-dev.zip -o drupal-lando.zip
unzip -q drupal-lando.zip && rm drupal-lando.zip && mv drupal-8.6.x-dev drupal-lando
cd drupal-lando

# Initialize and start Lando.
lando init --recipe drupal8 --webroot "." --name "drupal-lando" --yes
lando start

# Install Drush, then install Drupal inside Lando.
lando composer require drush/drush
lando drush si -y --site-name="Drupal Lando" --db-url=mysql://drupal8:drupal8@database/drupal8

# Test that the environment responds to a request.
curl -s http://drupallando.lndo.site

# TODO: Kill Lando.
# lando poweroff
