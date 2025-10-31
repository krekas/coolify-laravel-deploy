FROM serversideup/php:8.4-fpm-nginx

USER root

RUN curl -sL https://deb.nodesource.com/setup_22.x | bash -
RUN apt-get install -y nodejs

# Copy the existing application directory contents to the working directory
COPY . /var/www/html

# Copy the existing application directory permissions to the working directory
RUN chown -R www-data:www-data /var/www

USER www-data

RUN npm ci
RUN npm run build

RUN ls -la

RUN composer install --no-interaction --optimize-autoloader --no-dev