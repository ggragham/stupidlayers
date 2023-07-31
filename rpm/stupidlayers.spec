Name:           stupidlayers
Version:        v1.0.0
Release:        1%{?dist}
Summary:        Low latency key re-binding and hotkey utility for the sh*tty Motospeed CK62 keyboard on Linux

License:        Unlicense
Source0:        %{name}-%{version}.tar.xz

BuildRequires:  gcc, make
Requires:       systemd-udev, at
BuildArch:      x86_64

%description
Stupidlayers is a Linux tool tailored for Motospeed CK62 keyboard.
It provides efficient key re-binding and hotkey configuration using evdev and uinput for fast, reliable responses.


%prep
%{__rm} -rf %{name}-%{version}
%{__mkdir} -p %{name}-%{version}
%{__xz} -dc %{SOURCE0} | %{__tar} -xvf - -C %{_builddir}/%{name}-%{version} --strip-components 1


%build
cd %{name}-%{version}
%{__make}


%install
cd %{name}-%{version}
%{__make} install DESTDIR=%{buildroot}


%post
# Reload udev rules after package installation
/sbin/udevadm control --reload-rules
# Enable atd service after package installation
if [ $1 -eq 1 ] ; then
    /usr/bin/systemctl enable --now atd.service
fi


%postun
# Reload udev rules after package uninstallation
/sbin/udevadm control --reload-rules


%files
%license UNLICENSE
%doc README.md
/usr/local/bin/stupidlayers
%config(noreplace) %{_sysconfdir}/udev/rules.d/*


%changelog
* Sun Jul 30 2023 Grell Gragham <gragham@protonmail.com>
- Initial package
