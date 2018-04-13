# Drupal, the Fastest

[![Build Status](https://travis-ci.org/geerlingguy/drupal-the-fastest.svg?branch=master)](https://travis-ci.org/geerlingguy/drupal-the-fastest)

At DrupalCon Nashville 2018, I became deeply interested in the realm of first-time Drupal experiences, specifically around technical evaluation, and how people would get their feet wet with Drupal.

At the time, there are a large number of different ways people can start running and using a new Drupal installation, and documentation is all over the place. The intention of this project is to get a list of some of the most stable, simple, and quick ways to get a Drupal site installed and running for testing or site building, and measure a few benchmarks to help determine which one(s) might be best for Drupal newcomers.

## Methods

If the method is linked to a local build script, there is an automated build process that can be easily measured in terms of complexity, dependencies, and time required to build (basically, go from no Drupal to Drupal 8 site installed and accessible in the browser).

  1. [`drupal-quick-start.sh`](methods/drupal-quick-start.sh): Download Drupal and run a local environment with PHP and SQLite [using Drupal core's `quick-start`](https://www.drupal.org/project/drupal/issues/2911319).
  1. [`composer-drupal-vm.sh`](methods/composer-drupal-vm.sh): [Drupal Composer Project](https://github.com/drupal-composer/drupal-project) and [Drupal VM Docker Composer Plugin](https://github.com/geerlingguy/drupal-vm-docker).
  1. [`lando.sh`](methods/lando.sh): Download Drupal and run a local environment with [Lando](https://docs.devwithlando.io).
  1. [`drupal-vm-composer.sh`](methods/drupal-vm-composer.sh): [Drupal VM](https://www.drupalvm.com), Vagrant, and VirtualBox, with [Drupal Composer Project](https://github.com/drupal-composer/drupal-project).
  1. [`ddev-local.sh`](methods/ddev-local.sh): Download Drupal and run a local environment with [DDEV Local](https://github.com/drud/ddev).
  1. [`docksal.sh`](methods/docksal.sh): Run a local environment with [Docksal](https://docksal.io).
  1. [SimplyTest.me](https://simplytest.me).

The intention here is to make as automated a build process per tool as possible, so anyone can re-verify both the build process and the complexity and time taken for each.

### Test Philosophy

There is no one reliable way to measure "what is the [best|fastest|most efficient]" local development tool for Drupal. However, I define a basic set of tasks which apply universally and are consistently measurable across any of the tools available:

  1. Download and install dependencies (for things like VirtualBox or Docker CE, I discount the time involved downloading and installing them to be more consistent across modern environment tools).
  1. Download Drupal (or create codebase with Composer).
  1. Download the development environment tool (and install it if necessary).
  1. Start the local development environment.
  1. Install Drupal (either with `drush site-install` or an inbuilt method).
  1. Load the home page.

The scripts included with this repository are all meant to do the above process, end-to-end, repeatably, and ideally fully automated within Travis CI so there is little variance from workstation to workstation (e.g. I have a fast 2016 MacBook Pro with high speed Internet, but maybe someone else has an older PC with really slow Internet—that greatly affects benchmarking!).

## Results

Current as of: **April 12, 2018**

| Tool Name                           | Time to build | Required Dependencies | Steps | Environment |
| ----------------------------------- | ------------- | --------------------- | ----- | ----------- |
| Drupal quick-start                  | 02:00         | 2                     | 3     | Travis CI   |
| Composer with Drupal VM Docker      | 05:53         | 3                     | 4     | Travis CI   |
| Drupal with Lando                   | 03:01         | 1                     | 7     | Travis CI   |
| Drupal VM with Vagrant and Composer | 08:33         | 3                     | 2     | MacBook Pro |
| Drupal with DDEV Local              | 02:30         | 1                     | 6     | Travis CI   |
| Drupal with Docksal                 | TODO          | 1                     | 5     | Travis CI   |
| SimplyTest.me                       | TODO          | 0                     | 1     | Cloud       |

## License

This project is licensed under the MIT open source license.

## About the Author

[Jeff Geerling](https://www.jeffgeerling.com/) created the Drupal, the Fastest in 2018 to evaluate the Drupal evaluator experience.
