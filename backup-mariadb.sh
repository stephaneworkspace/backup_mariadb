#!/bin/bash
/usr/bin/mariadb-dump --defaults-file=/home/arch/backup_mariadb/my.cnf bress_db > bress_db_$(date +%Y-%m-%d).sql

