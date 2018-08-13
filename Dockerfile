# $ docker build -t webserver:latest .

FROM debian:9.5

LABEL maintainer="antoniociceroneweb@gmail.com"


ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2


#todo inserire file add.ini con aggiunta date.timezone nella cartella /etc/php/5.6/apache2/conf.d

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
    && apt-get install -y --no-install-recommends apache2 php5.6 libapache2-mod-php5.6 php5.6-mysql php5.6-intl php5.6-curl php-pear php5.6-cli php5.6-gd php5.6-imagick php5.6-mbstring php5.6-zip php5.6-xml \
    && a2enmod php5.6 \
    && a2enmod rewrite \
	&& php -r "copy('https://getcomposer.org/installer', '/tmp/composer-setup.php');" \
	&& php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout ${APACHE_LOG_DIR}/access.log \
	&& ln -sf /dev/stderr ${APACHE_LOG_DIR}/error.log

WORKDIR /var/www/html

COPY index.html /var/www/html/index.html
COPY info.php /var/www/html/info.php

EXPOSE 80 443

CMD /usr/sbin/apache2ctl -D FOREGROUND
