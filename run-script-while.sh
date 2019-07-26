#!/bin/bash

exec >>/tmp/script1.log 2>&1
set -xu

while true;
do
  /usr/local/bin/inotify-createrepo
  sleep 2
done
