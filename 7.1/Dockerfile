# $ docker build -t webserver:latest .

FROM debian:9.5

LABEL maintainer="Antonio Cicerone <antoniociceroneweb@gmail.com>"

ENV APACHE_LOG_DIR /var/log/apache2

ENV PHP_VERSION_INSTALL 7.1

ENV WEBSERVER_HOME /var/www/html


WORKDIR ${WEBSERVER_HOME}


RUN apt-get update \
    && apt-get install -y --no-install-recommends curl \
	&& apt-get install -y --no-install-recommends wget \
	&& apt-get install -y --no-install-recommends git \
	&& apt-get install -y --no-install-recommends nano \
	&& apt-get install -y --no-install-recommends vim \
	&& apt-get install -y --no-install-recommends zip \
	&& apt-get install -y --no-install-recommends unzip \
	&& apt-get install -y --no-install-recommends apt-transport-https lsb-release ca-certificates \
	&& wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
	&& echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
	&& apt-get update \
    && apt-get install -y --no-install-recommends apache2 php${PHP_VERSION_INSTALL} libapache2-mod-php${PHP_VERSION_INSTALL} php${PHP_VERSION_INSTALL}-mysql php${PHP_VERSION_INSTALL}-intl php${PHP_VERSION_INSTALL}-curl php-pear php${PHP_VERSION_INSTALL}-cli php${PHP_VERSION_INSTALL}-gd php${PHP_VERSION_INSTALL}-imagick php${PHP_VERSION_INSTALL}-mbstring php5.6-zip php${PHP_VERSION_INSTALL}-xml \
    && a2enmod php${PHP_VERSION_INSTALL} \
    && a2enmod rewrite \
	&& php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" \
	&& php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout ${APACHE_LOG_DIR}/access.log \
	&& ln -sf /dev/stderr ${APACHE_LOG_DIR}/error.log
	
#add timezone and memory_limit
RUN echo "date.timezone=Europe/Rome" >> /etc/php/${PHP_VERSION_INSTALL}/apache2/conf.d/dev.ini
RUN echo "memory_limit=-1" >> /etc/php/${PHP_VERSION_INSTALL}/apache2/conf.d/dev.ini	

VOLUME  ${WEBSERVER_HOME}

COPY index.html ${WEBSERVER_HOME}/index.html
COPY info.php ${WEBSERVER_HOME}/info.php

EXPOSE 80 443

CMD /usr/sbin/apache2ctl -D FOREGROUND
