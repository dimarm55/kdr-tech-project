#!/bin/bash

FILES_BACKUP_STORAGE=/srv/backup/files/
MYSQL_BACKUP_STORAGE=/srv/backup/mysql/

echo "Which copy do you want to use? Type copy in the following format: yyyy-mm-dd"
read copy

if ls "$FILES_BACKUP_STORAGE"/*_"$copy"* >/dev/null 2>&1 && \
   ls "$MYSQL_BACKUP_STORAGE"/*_"$copy"* >/dev/null 2>&1; then
        cowsay "Begin restoration"
	podman-compose stop >/dev/null

	rm -rf /app/data/html/
	rm -rf /app/data/mysql/*

	tar -xf $FILES_BACKUP_STORAGE/kdr_tech_$copy.tar.gz -C /app/data/

	podman-compose start >/dev/null
	
	cowsay "Waiting 20 sec for mysql activation"
	sleep 20
	gunzip -ck $MYSQL_BACKUP_STORAGE/kdr_tech_$copy.sql.gz | podman exec -i db mysql -u root kdr_tech

	cowsay "Restoration has finished!!!"
else
	echo "There is no such backup"
fi       

