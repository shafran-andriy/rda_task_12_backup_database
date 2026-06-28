#! /bin/bash

# Create full backup the database ShopDB
mysqldump -u $DB_USER -p$DB_PASSWORD --databases ShopDB --result-file=ShopDB-Full.sql --no-create-db


# Check if the source database directory exists
if [ -d "/var/lib/mysql/ShopDBReserve" ]; then
    # Restore full backup the database ShopDB in the database ShopDBReserve
    mysqldump -u $DB_USER -p$DB_PASSWORD ShopDBReserve < ShopDB-Full.sql
else
    mysql -u $DB_USER -p$DB_PASSWORD < create-database.sql
    sleep 5
    mysqldump -u $DB_USER -p$DB_PASSWORD ShopDBReserve < ShopDB-Full.sql
fi


# Check if the source database directory exists
if [ -d "/var/lib/mysql/ShopDB" ]; then
    # Copy with overwrite (-r for recursive, -f for force overwrite)
    cp -r /var/lib/mysql/ShopDB /var/lib/mysql/ShopDBDevelopment
else
    echo "Database directory /var/lib/mysql/ShopDB does not exist."
fi
