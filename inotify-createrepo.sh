#!/bin/bash

source /etc/inotify-createrepo.conf
LOGFILE=/var/log/inotify-createrepo.log

function monitoring() {
    inotifywait -e create,delete -msrq --exclude ".repodata|.olddata|repodata" "${REPO}" | while read events 
    do
      echo $events >> $LOGFILE
      touch /tmp/need_create
    done
}

function run_createrepo() {
  while true; do
    if [ -f /tmp/need_create ];
    then
      rm -f /tmp/need_create
      echo "start createrepo $(date --rfc-3339=seconds)"
      /usr/bin/createrepo --update "${REPO}"
      echo "finish createrepo $(date --rfc-3339=seconds)"
    fi
    sleep 1
  done
}


echo "Start filesystem monitoring: Directory is $REPO, monitor logfile is $LOGFILE"
monitoring >> $LOGFILE &
run_createrepo >> $LOGFILE &
