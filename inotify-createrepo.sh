#!/bin/bash

source /etc/inotify-createrepo.conf

while true;
do
  for DIR in ${REPO[*]}
  do
  inotifywait -mr -e create,modify,close_write,delete --exclude ".repodata|.olddata|repodata" "${DIR}" | createrepo "${DIR}"
  sleep 10
  done
done
