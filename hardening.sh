#!/bin/bash
# Purpose:   Updating software with custom messages and an update log.
# Date:    09.01.2016
# Version:    16.9.1

echo -e "Server Updating : "  > /home/.hardening.log
sudo apt-get update >> /home/.hardening.log
sudo apt-get upgrade -yy >> /home/.hardening.log


echo -e "Delete Telenet" >> /home/.hardening.log
sudo apt remove telnet -yy >> /home/.hardening.log

echo -e "Delete Aplikasi openoffice* thumb " >> /home/.hardening.log
sudo apt remove openoffice* && sudo apt remove thumb -yy >> /home/.hardening.log

echo -e "Downloading Rkhunter"
wget https://telkomuniversity.dl.sourceforge.net/project/rkhunter/rkhunter/1.4.6/rkhunter-1.4.6.tar.gz

echo -e "Ekstrak Rkhunter"
tar -xvf rkhunter-1.4.6.tar.gz
cd rkhunter-1.4.6/

echo -e "Install Rkhunter & Run"
./installer.sh --install >> /home/.hardening.log
rkhunter --check  >> /home/.hardening.log
rm -r rkhunter-1.4.6
rm rkhunter-1.4.6.tar.gz


echo -e "Install CSF "  >> /home/.hardening.log
cd /usr/src
rm -fv csf.tgz
wget https://download.configserver.com/csf.tgz
tar -xzf csf.tgz
cd csf
sh install.sh

echo -e "Matikan IP V6"  >> /home/.hardening.log

printf "#Konfigurasi mematikan IP V6\nnet.ipv6.conf.all.disable_ipv6 = 1\nnet.ipv6.conf.default.disable_ipv6 = 1\nnet.ipv6.conf.lo.disable_ipv6 = 1
" >> /etc/sysctl.conf
sysctl -p >> /home/.hardening.log

echo -e "Disable ftpd & sshd"  >> /home/.hardening.log
service ftpd stop
service sshd stop

echo -e "Cek Services sshd"  >> /home/.hardening.log
service sshd status   >> /home/.hardening.log

echo -e "Hardening Selesai"
rm hardening.sh
