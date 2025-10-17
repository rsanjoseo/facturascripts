FROM php:8.2-fpm

# Instala herramientas y extensiones necesarias
RUN apt-get update && apt-get install -y \
    libzip-dev \
    zip \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    mariadb-client \
    git \
    curl \
    nano \
    && docker-php-ext-install zip pdo pdo_mysql mysqli pgsql mbstring exif pcntl bcmath gd soap

# Instala Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instala Posgres
RUN apt-get update && apt-get install -y libpq-dev \
    && docker-php-ext-install pgsql

WORKDIR /var/www/html

EXPOSE 9000

CMD ["php-fpm"]