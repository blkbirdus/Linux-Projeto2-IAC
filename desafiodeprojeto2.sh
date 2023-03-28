#!/bin/bash

apt-get update -y && sudo apt-get upgrade -y
apt-get install apache2 unzip unrar -y
cd /tmp
wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip
unzip main.zip
cd linux-site-dio-main
cp -R * /var/www/html
