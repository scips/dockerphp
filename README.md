# Travis ready docker for php with local composer

This is a docker for:

* Github private repository connection
* PHP
* Composer
* Lint: **php -l**
* Unit test: **phpunit**
* Coding Style: **phpcs**
* Code coverage: **phpcov**

## Guidelines

Here is what your **.travis.yml** should looks like.

Assuming **src/** contains the source and **tests/** the tests with a phpunit.xml in **tests/**.

Replace:

* **travis-clone-folder**: where travis has cloned the git repo
* **docker-folder**: local docker folder

```
sudo: required
services:
 - docker
branches:
  only:
  - master
language: generic
before_install:
- docker pull scips/dockerphp
install:
- docker run -dit --name="dockerphp" -v /home/travis/build/<travis-clone-folder>:<docker-folder> scips/dockerphp /bin/bash
- docker ps -a
- docker exec dockerphp /bin/bash -c "mkdir ~/.ssh"
- docker exec dockerphp /bin/bash -c "mkdir ~/coverage"
- docker exec dockerphp /bin/bash -c "composer self-update"
- cat ~/.ssh/id_
- docker exec dockerphp /bin/bash -c "cd <docker-folder>;composer install"
- docker exec dockerphp /bin/bash -c "php -v"
script:
- docker exec dockerphp /bin/bash -c "find <docker-folder>/src -path ./bin -prune -o \( -name '*.php' -o -name '*.inc' \) -exec php -lf {} \;"
- docker exec dockerphp /bin/bash -c "<docker-folder>/vendor/bin/phpunit -c <docker-folder>/tests/phpunit.xml --colors --coverage-php ~/coverage/tests.cov"
- docker exec dockerphp /bin/bash -c "<docker-folder>/vendor/bin/phpcs --runtime-set ignore_warnings_on_exit 1 <docker-folder>/src"
- docker exec dockerphp /bin/bash -c "<docker-folder>/vendor/bin/phpcov merge --clover <docker-folder>/build/logs/clover.xml ~/coverage"

```

## Build

```
docker build -t dockerphp:latest .
```

## Run

**Whatch out, this docker use your host ssh-agent to access private github repositories you have access**

### Local computer

```
docker run -dit --name="dockerphp" -v (readlink -f $SSH_AUTH_SOCK):/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent -v /fullpath/to/your/code:/root/mylib/ scips/dockerphp /bin/bash
```

### Travis

```
docker run -dit --name="dockerphp" -v (readlink -f $SSH_AUTH_SOCK):/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent -v /home/travis/build/<travis-clone-folder>:<docker-folder> scips/dockerphp /bin/bash
```
