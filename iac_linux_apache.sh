#!/bin/bash

echo "Olá. Boas vindas a RadianteLTDA, que seu dia aqui seja Radiante!!!"
echo "Atualizando Sistema, Aguarde...."
sudo apt-get update -y && sudo apt-get upgrade -y

echo "Instalando o Apache..."
sudo apt-get install apache2 -y

echo "Instalando o Unzip..."
sudo apt-get install unzip -y

echo "Baixando aplicação, aguarde um momento..."
sudo wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip -P /tmp

echo "Descompactando arquivo..."
unzip /tmp/main.zip -d /tmp

echo "Copiando Arquivos para o apache..."
sudo mv -v /tmp/linux-site-dio-main/* /var/www/html

echo "Parabéns, seu site está disponivel para uso!!!"
echo "Aproveite que continue sempre Radiante!"
