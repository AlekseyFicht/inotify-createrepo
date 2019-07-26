#!/bin/bash

exec >>/tmp/script.log 2>&1
set -xu

source /etc/inotify-createrepo.conf

while true;
do
  /usr/bin/inotifywait -mr -e create,modify,close_write,delete --exclude ".repodata|.olddata|repodata" "${REPO}" | /usr/bin/createrepo "${REPO}"
  sleep 2
done
