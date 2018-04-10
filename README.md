# Drupal, the Fastest

[![Build Status](https://travis-ci.org/geerlingguy/drupal-the-fastest.svg?branch=master)](https://travis-ci.org/geerlingguy/drupal-the-fastest)

At DrupalCon Nashville 2018, I became deeply interested in the realm of first-time Drupal experiences, specifically around technical evaluation, and how people would get their feet wet with Drupal.

At the time, there are a large number of different ways people can start running and using a new Drupal installation, and documentation is all over the place. The intention of this project is to get a list of some of the most stable, simple, and quick ways to get a Drupal site installed and running for testing or site building, and measure a few benchmarks to help determine which one(s) might be best for Drupal newcomers.

## Methods

If the method is linked to a local build script, there is an automated build process that can be easily measured in terms of complexity, dependencies, and time required to build (basically, go from no Drupal to Drupal 8 site installed and accessible in the browser).

  1. [`git-clone-local.sh`](methods/git-clone-local.sh): Git clone and run a local environment with PHP and SQLite [using Drupal core](https://www.drupal.org/project/drupal/issues/2911319).
  1. [`composer-drupal-vm.sh`](methods/composer-drupal-vm.sh): [Drupal Composer Project](https://github.com/drupal-composer/drupal-project) and [Drupal VM Docker Composer Plugin](https://github.com/geerlingguy/drupal-vm-docker).
  1. [`git-clone-lando.sh`](methods/git-clone-lando.sh): Git clone and run a local environment with [Lando](https://docs.devwithlando.io).
  1. [`drupal-vm-composer.sh`](methods/drupal-vm-composer.sh): [Drupal VM](https://www.drupalvm.com), Vagrant, and VirtualBox, with [Drupal Composer Project](https://github.com/drupal-composer/drupal-project).
  1. [SimplyTest.me](https://simplytest.me).
  1. Try Drupal, hosting provider 1.
  1. Try Drupal, hosting provider 2.
  1. Try Drupal, hosting provider 3.

The intention here is to make as automated a build process per tool as possible, so anyone can re-verify both the build process and the complexity and time taken for each.

## Results

TODO: Results will be posted here once the methods are fleshed out a little more.

| Tool Name                           | Time to build | No. of Required Dependencies | No. of Steps |
| ----------------------------------- | ------------- | ---------------------------- | ------------ |
| Git clone local                     | TODO          | TODO                         | TODO         |
| Composer with Drupal VM Docker      | TODO          | TODO                         | TODO         |
| Git Clone with Lando                | TODO          | TODO                         | TODO         |
| Drupal VM with Vagrant and Composer | TODO          | TODO                         | TODO         |
| SimplyTest.me                       | TODO          | TODO                         | TODO         |

## License

This project is licensed under the MIT open source license.

## About the Author

[Jeff Geerling](https://www.jeffgeerling.com/) created the Drupal, the Fastest in 2018 to evaluate the Drupal evaluator experience.
