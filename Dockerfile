FROM php:8.2-apache

ARG DEFAULT_USER
ARG NODE_VERSION

RUN apt update 
RUN apt install -y git libicu-dev vim curl wget tzdata nano htop youtube-dl \
	locales less libaio1 sqlite3 p7zip-full unzip libpng-dev \
	libmagickwand-dev libmemcached-dev zip unzip libzip-dev libreadline-dev \
	libmcrypt-dev ffmpeg libonig-dev libcurl4 libcurl4-openssl-dev pkg-config

RUN docker-php-ext-configure intl
RUN docker-php-ext-install mysqli 
RUN docker-php-ext-install pdo_mysql 
RUN docker-php-ext-install bcmath 
RUN docker-php-ext-install gd 
RUN docker-php-ext-install intl
RUN docker-php-ext-install iconv
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install curl
RUN docker-php-ext-install sockets
RUN docker-php-ext-install ctype
RUN docker-php-ext-install xml

RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt autoclean

RUN sed -i -e 's/# es_MX.UTF-8 UTF-8/es_MX.UTF-8 UTF-8/' /etc/locale.gen
RUN sed -i -e 's/# es_MX.ISO-8859-1/es_MX.ISO-8859-1 ISO-8859-1/' /etc/locale.gen
RUN locale-gen
ENV LANG es_MX.UTF-8
ENV LANGUAGE es_MX:es
ENV LC_ALL es_MX.UTF-8

RUN a2enmod rewrite

RUN echo 'root:asdf1234' | chpasswd

RUN groupadd -g 1000 ${DEFAULT_USER}
RUN useradd -u 1000 -g ${DEFAULT_USER} \
    --create-home --home-dir=/home/${DEFAULT_USER} \
    --shell=/bin/bash ${DEFAULT_USER}

RUN usermod -aG www-data ${DEFAULT_USER}

RUN mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

USER ${DEFAULT_USER}
WORKDIR /home/${DEFAULT_USER}

RUN mkdir bin
ENV PATH $PATH:/home/${DEFAULT_USER}/bin

ENV NVM_DIR=/home/${DEFAULT_USER}/.nvm
RUN mkdir -p ${NVM_DIR}
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
        && . ${NVM_DIR}/nvm.sh && nvm install ${NODE_VERSION} && nvm install node && nvm install \
        --lts --latest-npm && nvm install lts/hydrogen && nvm alias default lts/hydrogen && nvm use \
        default

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=bin --filename=composer

RUN echo '<?php phpinfo();' > /var/www/html/info.php
RUN echo '<?php include "./info.php";' > /var/www/html/index.php

COPY .vimrc /home/${DEFAULT_USER}/.vimrc
