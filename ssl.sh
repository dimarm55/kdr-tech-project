#!/bin/bash

python3 -m http.server 80 --directory ./data/html &
pid=$!

certbot certonly --webroot -w ./data/html -d kdr-tech.cfd -d www.kdr-tech.cfd

kill $pid
