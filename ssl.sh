#!/bin/bash

python3 -m http.server 80 --directory /var/www/html &
pid=$!

certbot certonly --webroot -w /var/www/html -d kdr-tech.cfd -d www.kdr-tech.cfd -d roundcube.kdr-tech.cfd

kill $pid
