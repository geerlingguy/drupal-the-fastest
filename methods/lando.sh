#!/bin/bash
#
# Drupal install method:
# Download Drupal and run a local environment with Lando.
# Based on: https://www.jeffgeerling.com/blog/2018/getting-started-lando-testing-fresh-drupal-8-umami-site
#
# Prerequisites:
#   - Install Docker CE.

# Variables.
INSTALL_PROFILE="standard"
LANDO_VERSION="v3.0.0-aft.2"
LANDO_DMG="https://github.com/lando/lando/releases/download/$LANDO_VERSION/lando-$LANDO_VERSION.dmg"
LANDO_DEB="https://github.com/lando/lando/releases/download/$LANDO_VERSION/lando-$LANDO_VERSION.deb"

# Install Lando.
if ! lando version ; then
    if [ "$(uname)" == "Darwin" ]; then
        # Install with .dmg on macOS.
        curl $LANDO_DMG -O -L
        # TODO: Install LandoInstaller.pkg from the DMG.
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        # Install with .deb package.
        curl $LANDO_DEB -O -L
        sudo dpkg -i $(basename $LANDO_DEB)
    fi
fi

# Download and expand Drupal.
curl -O https://ftp-origin.drupal.org/files/projects/drupal-8.8.x-dev.zip
unzip -q drupal-8.8.x-dev.zip && rm drupal-8.8.x-dev.zip && mv drupal-8.8.x-dev drupal-lando
cd drupal-lando

# Initialize and start Lando.
lando init --source cwd --recipe drupal8 --webroot "." --name "drupal-lando" --yes
lando start

# Allow Lando to fully start, and avoid this error:
# "Failed to create database: ERROR 2003 (HY000): Can't connect to MySQL server on 'database'"
sleep 2

# Install Drupal inside Lando.
lando drush si -y --site-name="Drupal Lando" --db-url=mysql://drupal8:drupal8@database/drupal8

# Test that the environment responds to a request.
curl -s http://drupal-lando.lndo.site

# Kill Lando.
lando poweroff
