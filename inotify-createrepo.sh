#!/bin/bash

source /etc/inotify-createrepo.conf
LOGFILE=/var/log/inotify-createrepo.log

function monitoring() {
    inotifywait -e create,delete,modify,move -msrq --exclude ".repodata|.olddata|repodata" "${REPO}" | while read events 
    do
      echo $events >> $LOGFILE        
      /usr/bin/createrepo "${REPO}"
      sleep 10
    done
}

echo "Start filesystem monitoring: Directory is $REPO, monitor logfile is $LOGFILE"
monitoring $DIR  >> $LOGFILE &
