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
LANDO_DEB="https://github.com/lando/lando/releases/download/v3.0.0-beta.40/lando-v3.0.0-beta.40.deb"
LANDO_DEB_FILENAME="lando-v3.0.0-beta.40.deb"

# Install Lando.
if [ "$(uname)" == "Darwin" ]; then
    # TODO: Use .dmg instead (can I download and install with brew manually?).
    # See: https://github.com/lando/lando/issues/598#issuecomment-380244198
    # Install with Homebrew on macOS.
    brew cask install lando
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # TODO: Support other OSes besides Debian derivatives.
    # Install with .deb package.
    wget $LANDO_DEB
    sudo dpkg -i $LANDO_DEB_FILENAME
fi

# Clone Drupal.
git clone --branch 8.6.x https://git.drupal.org/project/drupal.git drupal-lando
cd drupal-lando

# Initialize and start Lando.
lando init --recipe drupal8 --webroot "." --name "Drupal Lando" --yes
lando start

# Install dependencies with Lando Composer.
lando composer install

# TODO: Install the Drupal site (with Drush?).
# TODO: Test that the environment responds to a request?
# TODO: Kill Lando? (`lando poweroff`).
