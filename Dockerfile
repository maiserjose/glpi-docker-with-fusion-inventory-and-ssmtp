FROM php:7.3.4-apache

RUN chmod +x /usr/local/bin/*

## Install and enable requirement for GLPI
RUN apt-get update && apt-get install -y --no-install-recommends \
	vim \
	nano \
	cron \
	ssmtp \
	libxml2-dev \
	libpng-dev \
	libjpeg-dev \
	libldap2-dev \
	libc-client-dev \
	libkrb5-dev \
	libssl-dev ; \
	rm -rf /var/lib/apt/lists/*

# Set the locale
RUN apt-get clean && apt-get update && apt-get install -y locales
RUN sed -i -e 's/# pt_BR.UTF-8 UTF-8/pt_BR.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=pt_BR.UTF-8

ENV LANG pt_BR.UTF-8 

# Copy the configuration files
COPY apache-prod/glpi.conf /etc/apache2/sites-available/glpi.conf
COPY apache-prod/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
RUN rm -f /etc/apache2/sites-enabled/000-default.conf
RUN ln -s /etc/apache2/sites-available/glpi.conf /etc/apache2/sites-enabled/000-default.conf

# Defining container's timezone
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Copy PHP's timezone configuration
COPY ./timezone.ini /usr/local/etc/php/conf.d/timezone.ini

RUN docker-php-ext-configure gd --with-jpeg-dir=/usr/include --with-png-dir=/usr/include ; \
	docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ ; \
	docker-php-ext-configure imap --with-kerberos --with-imap-ssl ; \
	docker-php-ext-configure opcache ; \
	docker-php-ext-configure xmlrpc ; \
	docker-php-ext-install gd ldap mysqli imap opcache xmlrpc exif intl

RUN printf "\n" | pecl install apcu apcu_bc-beta
RUN echo extension=apcu.so > /usr/local/etc/php/php.ini
RUN docker-php-ext-enable apc

## Download GLPI package from github latest version
#ADD https://github.com/glpi-project/glpi/releases/download/9.4.2/glpi-9.4.2.tgz /tmp/glpi.tgz

ENTRYPOINT ["docker-php-entrypoint"]


COPY apache2-foreground /usr/local/bin/
COPY cas.tgz /var/www/html/
RUN pear install cas.tgz
RUN chmod +x /usr/local/bin/apache2-foreground
EXPOSE 80 443
CMD ["apache2-foreground"]
