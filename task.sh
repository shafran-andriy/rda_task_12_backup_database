#! /bin/bash

# Create full backup the database ShopDB
mysqldump -u $DB_USER -p$DB_PASSWORD --databases ShopDB --result-file=ShopDB-Full.sql --no-create-db


# Check if the source database directory exists
if [ -d "/var/lib/mysql/ShopDBReserve" ]; then
    # Restore full backup the database ShopDB in the database ShopDBReserve
    mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve < ShopDB-Full.sql
else
    mysql -u root -p -e "CREATE DATABASE ShopDBReserve;"
    sleep 5
    mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve < ShopDB-Full.sql
fi


# Check if the source database directory exists
if [ -d "/var/lib/mysql/ShopDBDevelopment" ]; then
    mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --no-create-info --no-create-db > ShopDB-Data.sql
    mysql -u $DB_USER -p$DB_PASSWORD ShopDBDevelopment < ShopDB-Data.sql

else
    echo "Database directory /var/lib/mysql/ShopDB does not exist."
fi
