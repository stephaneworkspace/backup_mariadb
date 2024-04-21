#!/bin/bash

source /home/arch/swift-env/bin/activate
cd /home/arch/backup_mariadb/
CONTAINER_NAME="default"
DIRECTORY_NAME="mariadb_arch"

mkdir -p $DIRECTORY_NAME
#swift post $CONTAINER_NAME/$DIRECTORY_NAME

DATABASES=("bress_db")

DATE=$(date +%F)

for DB_NAME in "${DATABASES[@]}"
do
    BACKUP_FILE="${DIRECTORY_NAME}/${DB_NAME}_backup_${DATE}.sql"
    pg_dump -U postgres -d $DB_NAME > $BACKUP_FILE
    /usr/bin/mariadb-dump --defaults-file=/home/arch/backup_mariadb/my.cnf $DB_NAME > $BACKUP_FILE
    swift upload $CONTAINER_NAME $BACKUP_FILE
    rm $BACKUP_FILE
done

#swift list $CONTAINER_NAME --prefix $DIRECTORY_NAME/
rm -rf $DIRECTORY_NAME
