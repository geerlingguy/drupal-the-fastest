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
if ! `lando version` ; then
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

# Clone Drupal.
git clone --branch 8.6.x https://git.drupal.org/project/drupal.git drupal-lando
cd drupal-lando

# Initialize and start Lando.
lando init --recipe drupal8 --webroot "." --name "Drupal Lando" --yes
lando start

# Install dependencies with Lando Composer.
lando composer install

# Install Drupal with Drush inside Lando.
lando drush si

# TODO: Test that the environment responds to a request?
# TODO: Kill Lando? (`lando poweroff`).
