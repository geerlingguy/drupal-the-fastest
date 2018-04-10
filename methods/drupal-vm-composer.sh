#!/bin/bash
#
# Drupal install method:
# Drupal VM, Vagrant, and VirtualBox, with Drupal Composer Project.
# Based on: https://www.drupalvm.com
#
# Prerequisites:
#   - Install Git.
#   - Install Vagrant.
#   - Install VirtualBox.

# Variables.
INSTALL_PROFILE="standard"

# Clone Drupal VM.
git clone git@github.com:geerlingguy/drupal-vm.git drupal-vm-composer
cd drupal-vm-composer

# Create a config.yml file with our customizations.
echo "drupal_install_profile: $INSTALL_PROFILE" > config.yml

# Run the local development environment.
vagrant up

# TODO: Test that the environment responds to a request?
# TODO: Destroy the environment? (vagrant destroy)
