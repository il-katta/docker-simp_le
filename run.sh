#!/bin/sh
set -xe
# starting wevserver
mkdir -p /var/www/html
webfsd -l /dev/stdout -p 80 -j
# cmd
/usr/local/bin/simp_le --default_root /var/www/html $@
