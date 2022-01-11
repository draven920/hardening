#!/bin/bash
# Purpose:   Updating software with custom messages and an update log.
# Date:    09.01.2016
# Version:    16.9.1

echo -e "Server Updating : " > /home/user/.hardening.log
sudo apt-get update -yy >> /home/user/.hardening.log

echo -e "Delete Telenet"
sudo apt remove telnet -yy >> /home/user/.hardening.log

echo -e "Delete Aplikasi openoffice* thumb& "
sudo apt remove openoffice* && sudo apt remove thumb -yy >> /home/user/.hardening.log

echo -e "Downloading Rkhunter"
wget https://telkomuniversity.dl.sourceforge.net/project/rkhunter/rkhunter/1.4.6/rkhunter-1.4.6.tar.gz

echo -e "Ekstrak Rkhunter"
tar -xvf rkhunter-1.4.6.tar.gz
cd rkhunter-1.4.6/

echo -e "Install Rkhunter & Run"
./installer.sh --install >> /home/user/.hardening.log
rkhunter --check

echo -e "Hardening Selesai"
