#!/bin/bash

echo "running entrypoint script";
cd /var/www/public_html;

until nc -z $DBHOST $DBPORT; do
    echo "$(date) - waiting for db..."
    sleep 1
done

SQL="mysql -h $DBHOST -u root";

echo "Creating database...";
MYSQL_PWD=$DBPASS $SQL -e "CREATE DATABASE IF NOT EXISTS $DBNAME DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;";

echo "Setting directory permissions";
chown -R www-data.www-data /var/www;

exec "$@"
