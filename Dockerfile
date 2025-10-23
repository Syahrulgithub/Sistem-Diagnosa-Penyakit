FROM php:8.2-cli

RUN apt-get update && apt-get install -y unzip git libpng-dev libjpeg-dev libfreetype6-dev zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app

COPY . .

RUN cp .env.example .env

RUN composer install --no-dev --optimize-autoloader

RUN php artisan key:generate

EXPOSE 8000

# ✅ FIXED: ensure $PORT is treated as a number and has fallback
CMD php artisan serve --host=0.0.0.0 --port=${PORT:-8000}
