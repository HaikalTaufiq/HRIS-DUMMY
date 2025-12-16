#!/bin/bash
set -e

echo "🚀 Starting Laravel container..."

echo "🛠 Debug Environment Variables:"
echo "APP_NAME = '$APP_NAME'"
echo "APP_ENV = '$APP_ENV'"
echo "DB_DATABASE = '$DB_DATABASE'"
echo "DB_USERNAME = '$DB_USERNAME'"

# -----------------------------
# Tunggu sampai database siap
# -----------------------------
echo "📡 Menunggu database MySQL..."

DB_HOST=${DB_HOST:-$MYSQLHOST}
DB_PORT=${DB_PORT:-$MYSQLPORT}
DB_USERNAME=${DB_USERNAME:-$MYSQLUSER}
DB_PASSWORD=${DB_PASSWORD:-$MYSQLPASSWORD}

until MYSQL_PWD="$DB_PASSWORD" mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USERNAME" -e "SELECT 1;" > /dev/null 2>&1; do
  echo "⏳ Menunggu MySQL..."
  sleep 3
done

echo "✅ MySQL siap, lanjut proses Laravel..."

# -----------------------------
# Install dependencies
# -----------------------------
composer install --no-interaction --optimize-autoloader

# -----------------------------
# Laravel housekeeping
# -----------------------------
php artisan key:generate --force || true
php artisan migrate --force

php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan optimize

# -----------------------------
# Start Laravel (foreground)
# -----------------------------
echo "🚀 Laravel siap dijalankan"
exec php artisan serve --host=0.0.0.0 --port=8080
