ARG USERID=1001


FROM php:7.2-fpm-alpine

COPY ./composer.lock  /var/www/html
COPY ./composer.json  /var/www/html

# RUN echo "${USERID}"



WORKDIR /var/www/html

#install extensions
RUN apk update && apk add --no-cache \
    build-base shadow vim curl \
    php7 \
    php7-fpm \
    php7-common \
    php7-pdo \
    php7-pdo_mysql \
    php7-mysqli \
    php7-mcrypt \
    php7-mbstring \
    php7-xml \
    php7-openssl \
    php7-json \
    php7-phar \
    php7-zip \
    php7-gd \
    php7-dom \
    php7-session \
    php7-zlib
    
# ENV USERID=$USERID
RUN usermod -u "${USERID}" www-data

RUN docker-php-ext-install pdo pdo_mysql
RUN docker-php-ext-enable pdo_mysql

ENV COMPOSER_HOME /composer
ENV PATH ./vendor/bin:/composer/vendor/bin:$PATH
ENV COMPOSER_ALLOW_SUPERUSER 1

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# Remove Cache
RUN rm -rf /var/cache/apk/*

# Add UID '1000' to www-data

# Copy existing application directory permissions
RUN chown -R www-data:www-data /var/www
COPY --chown=www-data:www-data . /var/www/html
RUN  chmod -R 777   /var/www/html/storage/
RUN  chmod  -R 777 /var/www/html/bootstrap/cache
# Change current user to www
USER www-data

RUN ls /var/www/html -lsa

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]