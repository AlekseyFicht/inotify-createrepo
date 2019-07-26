#!/bin/bash

list_dependencies=(rpm-build rpmdevtools)

for i in ${list_dependencies[*]}
do
    if ! rpm -qa | grep -qw $i; then
        echo "__________Dont installed '$i'__________"
        #yum -y install $i
    fi
done

rm -f {RPMS,SRPMS,BUILD,SOURCES,SPECS}
mkdir {RPMS,SRPMS,BUILD,SOURCES,SPECS}

cp inotify-createrepo.* SOURCES

rpmbuild -bb --define "_topdir $PWD" inotify-createrepo.spec
