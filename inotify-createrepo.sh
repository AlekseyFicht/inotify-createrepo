#!/bin/bash

exec >>/tmp/script2.log 2>&1
set -xu

source /etc/inotify-createrepo.conf
/usr/bin/inotifywait -mr -e create,modify,close_write,delete --exclude ".repodata|.olddata|repodata" "${REPO}" | /usr/bin/createrepo "${REPO}"
