FROM docker.iranrepo.ir/php:8.0.13-fpm

RUN apt-get update --fix-missing -y \
        && apt-get upgrade -y \
        && apt-get install -y nano htop procps

RUN apt-get install -y libcurl4-openssl-dev
RUN docker-php-ext-install curl

########## PHP exif ##########
RUN docker-php-ext-install exif


########## PHP bcmath ##########
RUN docker-php-ext-install bcmath


########## PHP pdo ##########
RUN docker-php-ext-install pdo pdo_mysql

########## PHP soap #########
RUN apt-get install -y \
     libxml2-dev \
     && docker-php-ext-install soap

########## PHP zip ##########
RUN apt-get install -y --no-install-recommends libzip-dev unzip \
        && docker-php-ext-install zip

RUN mkdir /var/www/.composer \
        && chown www-data:www-data /var/www/.composer
COPY --from=docker.iranrepo.ir/composer:2 /usr/bin/composer /usr/bin/composer
######## ini ######
COPY php.ini-production ${PHP_INI_DIR}/php.ini
COPY opcache.ini ${PHP_INI_DIR}/conf.d/opcache.ini

RUN apt-get update --fix-missing -y \
        && apt-get upgrade -y \
        && apt-get install -y nano htop procps

RUN apt-get install -y libcurl4-openssl-dev
RUN docker-php-ext-install curl
########## SSL ##########
RUN apt-get install -y --no-install-recommends openssl

RUN apt update

######### Mysql client ######
RUN apt-get install -y default-mysql-client

RUN apt-get install -y --no-install-recommends libzip-dev unzip \
     && docker-php-ext-install zip

RUN chmod 777 -R .