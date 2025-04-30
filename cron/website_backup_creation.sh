#!/bin/bash

BACKUP_DIR=/app/backups/files
WEBSITE_LOCATION=/app/data/html/
CURRENT_DATE=$(date +"%Y-%m-%d")

find "$BACKUP_DIR" -type f -mtime +21 -name "*.sql.gz" -exec rm -f {} \;

tar -czvf "$BACKUP_DIR/kdr-tech-${CURRENT_DATE}.tar.gz" -C "$(dirname "$WEBSITE_LOCATION")" "$(basename "$WEBSITE_LOCATION")"
