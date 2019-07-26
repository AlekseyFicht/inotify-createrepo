#!/bin/bash

source /etc/inotify-createrepo.conf
LOGFILE=/var/log/inotify-createrepo.log
need_create="0"

function monitoring() {
    inotifywait -e create,delete -msrq --exclude ".repodata|.olddata|repodata" "${REPO}" | while read events 
    do
      echo $events >> $LOGFILE
      need_create="1"
    done
}

function run_createrepo() {
  while true; do
    if [ "$need_create" == "1" ];
    then
      /usr/bin/createrepo "${REPO}"
      sleep 5
    fi
  done
}


echo "Start filesystem monitoring: Directory is $REPO, monitor logfile is $LOGFILE"
monitoring >> $LOGFILE &
run_createrepo >> $LOGFILE &
