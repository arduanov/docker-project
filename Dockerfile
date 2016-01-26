#FROM debian:jessie
#
#RUN apt-get update && apt-get install -y  php5-cli php5-fpm php5-curl php5-sqlite php5-pgsql php5-mcrypt php5-intl --no-install-recommends && rm -r /var/lib/apt/lists/*
#
#COPY /conf/php-fpm.conf /etc/php5/fpm/pool.d/www.conf
#
#EXPOSE 9000
#CMD ["/usr/sbin/php5-fpm"]

FROM php:5.6-fpm

RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

ENV PG_MAJOR 9.5
ENV PG_VERSION 9.5.0-1.pgdg80+2

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list


RUN apt-get update && apt-get install -y \
        		libpq-dev=$PG_VERSION \
		        libfreetype6-dev \
		        libjpeg62-turbo-dev \
		        libmcrypt-dev \
		        libpng12-dev \
	            && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	            && docker-php-ext-install -j$(nproc) pdo_pgsql opcache json mbstring mcrypt \
	            && rm -r /var/lib/apt/lists/*

##
# composer
##
RUN curl -sS https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer
