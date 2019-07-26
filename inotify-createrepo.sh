#!/bin/bash

source /etc/inotify-createrepo.conf

while true; do
  inotifywait  -s -t 2 -r -e modify,close_write,move,create,delete --exclude ".repodata|.olddata|repodata" "${REPO}" | /usr/bin/createrepo "${REPO}"
done
