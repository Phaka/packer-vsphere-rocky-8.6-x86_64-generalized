# Use CDROM installation media
#repo --name="AppStream" --baseurl="http://download.rockylinux.org/pub/rocky/8.6/AppStream/x86_64/os/"
repo --name="AppStream" --baseurl=file:///run/install/sources/mount-0000-cdrom/AppStream
cdrom
# Use text install
text
# Don't run the Setup Agent on first boot
firstboot --disabled
eula --agreed
ignoredisk --only-use=sda
# Keyboard layouts
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network  --bootproto=dhcp --device=ens192 --ipv6=dhcp --activate
network  --hostname=rocky-8-amd64.oak02.bloudraak.net

# Root password
rootpw --iscrypted $6$j/FE.n3yO.A8.Cut$6uZN33UuA4scC8UBDVhrE0R23mwyx8fFyvxGOlAllYvMiB9CWV98OKmNPNW/9WZ0ZeEnNuzzko8zH7jluStvQ0

# System services
#selinux --permissive
#firewall --enabled
firewall --service=ssh
services --enabled="NetworkManager,sshd,chronyd"
# System timezone
timezone America/Los_Angeles --isUtc
# System booloader configuration
ignoredisk --only-use=sda
autopart --type=lvm
# Partition clearing information
clearpart --none --initlabel

skipx

reboot

%packages --ignoremissing --excludedocs
openssh-clients
curl
dnf-utils
drpm
net-tools
open-vm-tools
perl
perl-File-Temp
sudo
vim
wget
python3

# unnecessary firmware
-aic94xx-firmware
-atmel-firmware
-b43-openfwwf
-bfa-firmware
-ipw2100-firmware
-ipw2200-firmware
-ivtv-firmware
-iwl*-firmware
-libertas-usb8388-firmware
-ql*-firmware
-rt61pci-firmware
-rt73usb-firmware
-xorg-x11-drv-ati-firmware
-zd1211-firmware
-cockpit
-quota
-alsa-*
-fprintd-pam
-intltool
-microcode_ctl
%end

%addon com_redhat_kdump --disable
%end

%post

# Manage Ansible access
sed -i 's/^#?PermitRootLogin \(without-password\|forced-commands-only\|prohibit-password\|no\|yes\)/PermitRootLogin yes/' /etc/ssh/sshd_config

systemctl enable vmtoolsd
systemctl start vmtoolsd

%end