#!/bin/bash

list_dependencies=(rpm-build rpmdevtools)

for i in ${list_dependencies[*]}
do
    if ! rpm -qa | grep -qw $i; then
        echo "__________Dont installed '$i'__________"
        #yum -y install $i
    fi
done

cp inotify-createrepo.* SOURCES
cp inotify-createrepo-nginx.conf SOURCES

rpmbuild -bb --define "_topdir $PWD" inotify-createrepo.spec
