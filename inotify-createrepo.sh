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
      /usr/bin/createrepo "${REPO}"
      rm -f /tmp/need_create
      sleep 5
    fi
  done
}


echo "Start filesystem monitoring: Directory is $REPO, monitor logfile is $LOGFILE"
monitoring >> $LOGFILE &
run_createrepo >> $LOGFILE &
