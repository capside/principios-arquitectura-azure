#!/bin/bash
LOG=/root/base-provision.log
exec > $LOG
exec 2>&1

echo "---CUSTOM empieza---"
export DEBIAN_FRONTEND=noninteractive
apt-get -y update
apt-get install -y lsscsi
apt-get install -y python-pytest
apt-get install -y python-pip
echo "---CUSTOM pip y demas---"
pip install flask
mkdir /opt/flaskr
cd /opt/flaskr
git clone  https://github.com/pallets/flask.git
cd flask/examples/flaskr
pip install --editable .
export FLASK_APP=flaskr
flask initdb
flask run -h 0.0.0.0 -p 5001 &
echo "---CUSTOM termina---"
exit 0