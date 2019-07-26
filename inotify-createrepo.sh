#!/bin/bash

source /etc/inotify-createrepo.conf

while true; do
  inotifywait -r -e modify,close_write,move,create,delete --exclude ".repodata|.olddata|repodata" "${REPO}"
  echo "next line after inotifywait"

  sleep 2
done

# /usr/bin/createrepo "${REPO}"
