#!/bin/bash

# Full backup of ShopDB (schema + data), restore to ShopDBReserve
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve

# Data-only backup of ShopDB (no schema), restore to ShopDBDevelopment
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB | mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment
