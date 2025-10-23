# Gunakan image PHP dengan composer & extensions
FROM php:8.2-cli

# Install dependencies system
RUN apt-get update && apt-get install -y unzip git libpng-dev libjpeg-dev libfreetype6-dev zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /app

# Copy semua file ke container
COPY . .

# Install dependency Laravel
RUN composer install --no-dev --optimize-autoloader

# Generate APP_KEY
RUN php artisan key:generate

# Jalankan Laravel pakai port dari Railway
CMD php artisan serve --host=0.0.0.0 --port=${PORT}
