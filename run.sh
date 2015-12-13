#!/bin/sh
set -xe
# starting wevserver
mkdir -p /var/www/html
cd /var/www/html
webfsd -l /dev/stdout -p 80 -j
# cmd
cd /certs
/usr/local/bin/simp_le --default_root /var/www/html $@
