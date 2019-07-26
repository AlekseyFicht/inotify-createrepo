#!/bin/bash

source /etc/inotify-createrepo.conf

while true; do
  /usr/bin/inotifywait -mr -e create,modify,close_write,delete --exclude ".repodata|.olddata|repodata" "${REPO}" | /usr/bin/createrepo "${REPO}"
  sleep 2
done
