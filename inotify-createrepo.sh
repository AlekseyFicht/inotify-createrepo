#!/bin/bash

source /etc/inotify-createrepo.conf

while true;
do
  inotifywait -mr -e create,modify,close_write,delete --exclude ".repodata|.olddata|repodata" "${REPO}" | createrepo "${REPO}"
  sleep 10
done