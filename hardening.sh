#!/bin/bash
# Purpose:   Updating software with custom messages and an update log.
# Date:    09.01.2016
# Version:    16.9.1

echo -e "Server Updating : "  > /home/.hardening.log
sudo apt-get update 
sudo apt-get upgrade -yy 

read -n 1 -s -r -p "Press any key to continue"


echo -e "Delete Telenet" >> /home/.hardening.log
sudo apt remove telnet -yy

read -n 1 -s -r -p "Press any key to continue"

echo -e "Delete Aplikasi openoffice* thumb " >> /home/.hardening.log
sudo apt remove openoffice* && sudo apt remove thumb -yy 

read -n 1 -s -r -p "Press any key to continue"

echo -e "Downloading Rkhunter"
wget https://telkomuniversity.dl.sourceforge.net/project/rkhunter/rkhunter/1.4.6/rkhunter-1.4.6.tar.gz

echo -e "Ekstrak Rkhunter"
tar -xvf rkhunter-1.4.6.tar.gz
cd rkhunter-1.4.6/

echo -e "Install Rkhunter & Run"
./installer.sh --install

read -n 1 -s -r -p "Press any key to continue"

rkhunter --check 

read -n 1 -s -r -p "Press any key to continue"


echo -e "Install CSF "  >> /home/.hardening.log
cd /usr/src
rm -fv csf.tgz
wget https://download.configserver.com/csf.tgz
tar -xzf csf.tgz
cd csf
sh install.sh

read -n 1 -s -r -p "Press any key to continue"

echo -e "Matikan IP V6"  >> /home/.hardening.log

printf "#Konfigurasi mematikan IP V6\nnet.ipv6.conf.all.disable_ipv6 = 1\nnet.ipv6.conf.default.disable_ipv6 = 1\nnet.ipv6.conf.lo.disable_ipv6 = 1
" >> /etc/sysctl.conf
sysctl -p 

read -n 1 -s -r -p "Press any key to continue"

echo -e "Matikan CTRL + alt + Delete"  >> /home/.hardening.log
systemctl mask ctrl-alt-delete.target
systemctl daemon-reload

read -n 1 -s -r -p "Press any key to continue"

echo -e "Konfigurasi Standar Keamanan"  >> /home/.hardening.log
printf "#Konfigurasi standar keamanan partisi\ntmpfs /tmp tmpfs nosuid,noexec,nodev,rw 0 0\ntmpfs /var/tmp tmpfs nosuid,noexec,nodev,rw 0 0\ntmpfs /dev/shm tmpfs nosuid,noexec,nodev,rw 0 0\n
" >> /etc/fstab

read -n 1 -s -r -p "Press any key to continue"

echo -e "Hapus X Windows (Mode GUI) "  >> /home/.hardening.log
printf "id:3:initdefault:" >> /etc/inittab

read -n 1 -s -r -p "Press any key to continue"


echo -e "Disable Service"  >> /home/.hardening.log
netstat -pnltu

read -n 1 -s -r -p "Press any key to continue"

cd ~
rm hardening.sh
rm -r rkhunter-1.4.6
rm rkhunter-1.4.6.tar.gz

echo -e "Services SSHD Status"
service sshd Status

read -n 1 -s -r -p "Press any key to continue"


echo -e "Hardening Selesai"



