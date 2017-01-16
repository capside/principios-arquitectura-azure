#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
LOG=/opt/custom_install.log
exec > $LOG
exec 2>&1

echo "---CUSTOM empieza---"
apt-get -y update
apt-get install -y lsscsi python-pytest python-pip python-dev nginx
useradd -G www-data mario
chmod 755 /opt

echo "---CUSTOM pip---"
pip install uwsgi flask azure
cd /opt

echo "---CUSTOM Clonando app---"
git clone https://github.com/macrujugl/aplicacion
chown -R mario:www-data aplicacion
cd /opt/aplicacion

echo "---CUSTOM Arrancando servicios---"
cp aplicacion.service /etc/systemd/system/
systemctl start aplicacion
systemctl enable aplicacion

rm /etc/nginx/sites-enabled/default
cp aplicacion_web /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/aplicacion_web /etc/nginx/sites-enabled

systemctl restart nginx

echo "---CUSTOM termina---"
exit 0