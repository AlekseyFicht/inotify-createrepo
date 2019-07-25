%global _prefix /usr/local

Name:    inotify-createrepo
Version: 0.1
Release: 1
Summary: Createrepo backend daemon based on inotifywait
Group:   Development Tools
License: ASL 2.0
Source0: rpm-repository-mirroring.sh
Source1: nginx-rpm-repository-mirroring.conf
Source2: rpm-repository-mirroring.conf
Source3: rpm-repository-mirroring-cron
Requires: nginx
Requires: createrepo

%description

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p %{buildroot}/%{_bindir}
%{__install} -m 755 %{SOURCE0} %{buildroot}/%{_bindir}/%{name}
mkdir -p %{buildroot}/etc/nginx/conf.d/
cp -a %{SOURCE1} %{buildroot}/etc/nginx/conf.d/
cp -a %{SOURCE2} %{buildroot}/etc/
mkdir -p %{buildroot}/etc/cron.d/
cp -a %{SOURCE3} %{buildroot}/etc/cron.d/
mkdir -p %{buildroot}/var/www/repos

%files
%{_bindir}/%{name}
/etc/nginx/conf.d/nginx-rpm-repository-mirroring.conf
/etc/rpm-repository-mirroring.conf
/etc/cron.d/rpm-repository-mirroring-cron
%dir /var/www/repos
