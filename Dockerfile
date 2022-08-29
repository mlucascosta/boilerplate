FROM php:8.1-apache-buster

ENV APACHE_DOCUMENT_ROOT /var/www/html/public
ENV APACHE_LOG_DIR /var/log/apache2

RUN apt-get update && apt-get install git libzip-dev vim supervisor -y

RUN docker-php-ext-install zip mysqli pdo pdo_mysql

RUN a2enmod rewrite

RUN mkdir /var/log/webhook

COPY ./.docker/supervisor/conf.d /etc/supervisor/conf.d

COPY ./.docker/entrypoint /var/www/entrypoint

RUN chmod +x /var/www/entrypoint

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

COPY ./backend/composer.json ./var/www/html
COPY ./backend/composer.lock ./var/www/html

CMD bash -c "composer install"

COPY ./backend /var/www/html

WORKDIR /var/www/html

ENTRYPOINT [ "/var/www/entrypoint" ]