%global _prefix /usr/local

Name:    inotify-createrepo
Version: 0.8
Release: 4
Summary: Createrepo backend daemon based on inotifywait
Group:   Development Tools
License: ASL 2.0
Source0: inotify-createrepo.sh
Source1: inotify-createrepo.conf
Source2: inotify-createrepo.cron
Source3: inotify-createrepo.logrotate
Source4: inotify-createrepo.service
Requires: createrepo
Requires: inotify-tools

# Use systemd for fedora >= 18, rhel >=7, SUSE >= 12 SP1 and openSUSE >= 42.1
%define use_systemd (0%{?fedora} && 0%{?fedora} >= 18) || (0%{?rhel} && 0%{?rhel} >= 7) || (!0%{?is_opensuse} && 0%{?suse_version} >=1210) || (0%{?is_opensuse} && 0%{?sle_version} >= 120100)

%description
Createrepo backend daemon based on inotifywait

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p %{buildroot}/%{_bindir}
mkdir -p %{buildroot}/etc
mkdir -p %{buildroot}/etc/logrotate.d
mkdir -p %{buildroot}/etc/cron.d
%{__install} -m 755 %{SOURCE0} %{buildroot}/%{_bindir}/%{name}
cp -a %{SOURCE1} %{buildroot}/etc/
cp -a %{SOURCE2} %{buildroot}/etc/cron.d/
cp -a %{SOURCE3} %{buildroot}/etc/logrotate.d/
mkdir -p %{buildroot}/var/www/repos/rpm-repo/
mkdir -p %{buildroot}/var/www/inotify-createrepo/


%if %{use_systemd}
%{__mkdir} -p %{buildroot}%{_unitdir}
%{__install} -m644 %{SOURCE4} \
    %{buildroot}%{_unitdir}/%{name}.service
%endif

%post
%if %use_systemd
/usr/bin/systemctl daemon-reload
%endif

%preun
%if %use_systemd
/usr/bin/systemctl stop %{name}
%endif

%postun
%if %use_systemd
/usr/bin/systemctl daemon-reload
%endif

%files
%{_bindir}/%{name}
/etc/inotify-createrepo.conf
/etc/cron.d/inotify-createrepo.cron
/etc/logrotate.d/inotify-createrepo.logrotate
%dir /var/www/repos/rpm-repo/
%dir /var/www/inotify-createrepo/
%if %{use_systemd}
%{_unitdir}/%{name}.service
%endif
