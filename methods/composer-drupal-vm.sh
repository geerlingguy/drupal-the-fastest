#!/bin/bash
#
# Drupal install method:
# Drupal Composer Project and Drupal VM Docker Composer Plugin.
# Based on: https://www.jeffgeerling.com/blog/2018/modern-way-build-and-develop-drupal-8-sites-using-composer
#
# Prerequisites:
#   - Install PHP.
#   - Install Composer.
#   - Install Docker CE.

# Variables.
DOCROOT="/var/www/drupalvm/drupal/web"
INSTALL_PROFILE="standard"

# Create a Drupal project using Composer.
composer create-project drupal/recommended-project:^8@dev composer-drupal-vm --stability dev --no-interaction
cd composer-drupal-vm

# Add Drush.
composer require drush/drush

# Add the Drupal VM Docker Composer plugin.
composer require --dev geerlingguy/drupal-vm-docker

# Run the local development environment.
docker-compose up -d
sleep 10

# Install Drupal inside the container.
docker exec drupal_vm_docker bash -c "cd $DOCROOT && drush si -y $INSTALL_PROFILE --root=$DOCROOT --db-url=mysql://drupal:drupal@127.0.0.1/drupal"

# Test that the environment responds to a request.
curl -s http://localhost/

# Tear down the environment.
docker-compose down -v
