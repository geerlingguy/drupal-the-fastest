#!/bin/bash
#
# Drupal install method:
# Download Drupal and run a local environment with Docksal.
# Based on: https://docksal.readthedocs.io/en/master/getting-started/env-setup/
#
# Prerequisites:
#   - Install Docker CE.

# Variables.
INSTALL_PROFILE="standard"

# Install Docksal.
if ! fin version ; then
    curl -fsSL https://get.docksal.io | sh
fi

# Tell Docksal to always use native Docker.
if [ ! -f ~/.docksal/docksal.env ]; then
    mkdir ~/.docksal
    echo "DOCKER_NATIVE=1" > ~/.docksal/docksal.env
fi

# Start Docksal.
fin system start

# Create a new Docksal project.
git clone https://github.com/docksal/drupal8 drupal-docksal
cd drupal-docksal

# Initialize the project containers and install Drupal.
fin init

# Test that the environment responds to a request.
curl -s http://docksaldocksal.docksal

# Kill Docksal.
yes | fin rm
fin system stop
