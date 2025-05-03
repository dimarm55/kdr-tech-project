#!/bin/bash

# Set the backup directory
BACKUP_DIR="/srv/backup/mysql"

# Get the current date for file naming
CURRENT_DATE=$(date +"%Y-%m-%d")

# Find and delete backups older than 14 days
find "$BACKUP_DIR" -type f -mtime +21 -name "*.sql.gz" -exec rm -f {} \;

# Backup each database
for DB in $(/usr/bin/podman exec db mysql -uroot -e 'SHOW DATABASES;' | grep -Ev "(Database|information_schema|performance_schema|mysql|sys)")
do
    echo "Backing up database: $DB"
    /usr/bin/podman exec db mysqldump -uroot "$DB" | gzip > "$BACKUP_DIR/${DB}_${CURRENT_DATE}.sql.gz"
done

echo "Backup completed successfully!"
