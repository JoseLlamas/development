FROM php:8.1-apache

LABEL maintainer="Johann Hermine <nikola.tesla.130420@gmail.com>"
ENV PHP_ERROR_REPORTING E_ALL

ARG DEFAULT_USER=dorian

RUN echo 'nameserver 1.1.1.1' > /etc/resolv.conf

RUN apt update 
RUN apt install -y libicu-dev vim curl wget tzdata nano libpq-dev htop youtube-dl \
	locales less libaio1 sqlite3 p7zip-full unzip libpng-dev \
	libmagickwand-dev libmemcached-dev zip unzip libzip-dev libreadline-dev \
	libmcrypt-dev ffmpeg libonig-dev libcurl4 libcurl4-openssl-dev pkg-config

RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql
RUN docker-php-ext-configure intl

RUN docker-php-ext-install mysqli 
RUN docker-php-ext-install pdo_mysql 
RUN docker-php-ext-install pgsql 
RUN docker-php-ext-install pdo_pgsql 
RUN docker-php-ext-install bcmath 
RUN docker-php-ext-install gd 
RUN docker-php-ext-install intl
RUN docker-php-ext-install iconv
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install curl
RUN docker-php-ext-install sockets
RUN docker-php-ext-install ctype
RUN docker-php-ext-install soap
RUN docker-php-ext-install xml

RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt autoclean

RUN sed -i -e 's/# es_MX.UTF-8 UTF-8/es_MX.UTF-8 UTF-8/' /etc/locale.gen
RUN sed -i -e 's/# es_MX.ISO-8859-1/es_MX.ISO-8859-1 ISO-8859-1/' /etc/locale.gen
RUN locale-gen
ENV LANG es_MX.UTF-8
ENV LANGUAGE es_MX:es
ENV LC_ALL es_MX.UTF-8

ENV TZ UTC
RUN a2enmod rewrite

RUN echo 'root:lobo@estepario044@charlotte' | chpasswd

RUN groupadd -g 1000 ${DEFAULT_USER}
RUN useradd -u 1000 -g ${DEFAULT_USER} \
    --create-home --home-dir=/home/${DEFAULT_USER} \
    --shell=/bin/bash ${DEFAULT_USER}

RUN usermod -aG www-data ${DEFAULT_USER}
RUN echo 'dorian:lobo@estepario044@dorian' | chpasswd

RUN mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

USER ${DEFAULT_USER}
WORKDIR /home/${DEFAULT_USER}

RUN mkdir bin

ENV NVM_DIR=/home/${DEFAULT_USER}/.nvm

RUN mkdir -p ${NVM_DIR}
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash \
        && . ${NVM_DIR}/nvm.sh \
        && nvm install node \
        && nvm install --lts --latest-npm \
        && nvm use default

ENV NODE_PATH ${NVM_DIR}/v$NODE_VERSION/lib/node_modules
ENV PATH $NODE_PATH:$PATH:/home/${DEFAULT_USER}/bin

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=bin --filename=composer

RUN curl -fsSL https://deno.land/x/install/install.sh | sh

ENV DENO_INSTALL /home/${DEFAULT_USER}/.deno
ENV PATH ${DENO_INSTALL}/bin:$PATH

RUN /home/${DEFAULT_USER}/bin/composer global require laravel/installer
RUN ln -s /home/${DEFAULT_USER}/.composer/vendor/bin/laravel /home/${DEFAULT_USER}/bin

RUN echo '<?php phpinfo();' > /var/www/html/info.php
RUN echo '<?php include "./info.php";' > /var/www/html/index.php

COPY .vimrc /home/${DEFAULT_USER}/.vimrc

EXPOSE 80
