# Gunakan image PHP dengan composer & extensions
FROM php:8.2-cli

RUN apt-get update && apt-get install -y unzip git libpng-dev libjpeg-dev libfreetype6-dev zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app

COPY . .

# Install dependency Laravel
RUN composer install --no-dev --optimize-autoloader

# Copy .env.example ke .env (kalau belum ada)
RUN cp .env.example .env

# Generate APP_KEY
RUN php artisan key:generate

# Jalankan Laravel pakai port Railway
CMD php artisan serve --host=0.0.0.0 --port=${PORT}
