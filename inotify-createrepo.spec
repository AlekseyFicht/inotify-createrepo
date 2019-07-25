%global _prefix /usr/local

Name:    inotify-createrepo
Version: 0.1
Release: 1
Summary: Createrepo backend daemon based on inotifywait
Group:   Development Tools
License: ASL 2.0
Source0: inotify-createrepo.sh
Source1: inotify-createrepo-nginx.conf
Source2: inotify-createrepo.conf
Source3: inotify-createrepo.systemd
Requires: nginx
Requires: createrepo
Requires: inotify-tools

%description
Createrepo backend daemon based on inotifywait

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p %{buildroot}/%{_bindir}
%{__install} -m 755 %{SOURCE0} %{buildroot}/%{_bindir}/%{name}
mkdir -p %{buildroot}/etc/nginx/conf.d/
cp -a %{SOURCE1} %{buildroot}/etc/nginx/conf.d/
cp -a %{SOURCE2} %{buildroot}/etc/
mkdir -p %{buildroot}/var/www/repos/rpm-repo/

%files
%{_bindir}/%{name}
/etc/nginx/conf.d/inotify-createrepo-nginx.conf
/etc/inotify-createrepo.conf
%dir /var/www/repos/rpm-repo/
