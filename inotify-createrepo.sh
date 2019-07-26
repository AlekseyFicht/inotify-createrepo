#!/bin/bash

source /etc/inotify-createrepo.conf

while true; do
  inotifywait -m -s -t 2 -r -e close_write,move,create,delete --exclude ".repodata|.olddata|repodata" "${REPO}" | /usr/bin/createrepo "${REPO}"
done
