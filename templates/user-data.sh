#!/bin/bash

mkdir -p /var/www && cd /var/www
echo "App v${var.release}" >> index.html
python3 -m http.server 80