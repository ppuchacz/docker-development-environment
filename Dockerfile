FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get install -y  \
      lsb-release  \
      ca-certificates  \
      apt-transport-https  \
      software-properties-common

# install php 8.1
RUN add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-get -y install php8.1

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

# install symfony-cli
RUN echo 'deb [trusted=yes] https://repo.symfony.com/apt/ /' | tee /etc/apt/sources.list.d/symfony-cli.list && \
    apt-get update && \
    apt-get install -y symfony-cli

# install php extensions
RUN apt-get install -y \
      php8.1-xml \
      php8.1-pdo-mysql \
      php8.1-intl \
      php8.1-mbstring

