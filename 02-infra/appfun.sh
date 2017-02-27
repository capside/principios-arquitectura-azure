#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
declare -r LOG_FILE=/opt/custom_install.log

exec > $LOG_FILE
exec 2>&1

# Dirs declaration
declare -r APP_DIR=/opt/aplicacion
declare -r NGINX_SITES_ENABLED_DIR=/etc/nginx/sites-enabled

# Files declaration
declare -r APP_INI_FILE=$APP_DIR/aplicacion.ini
declare -r NGINX_CONF_FILE=/etc/nginx/sites-available/aplicacion_web
declare -r APP_SERVICE_FILE=/etc/systemd/system/aplicacion.service


declare -r REPO=https://github.com/cowbotic/app2
declare -r USER=mario
declare -r GROUP=www-data

# Packages to install, as arrays
declare -r -a PACKAGES=( lsscsi python-pytest python-pip python-dev nginx )
declare -r -a PYTHON_LIBS=( uwsgi flask azure )



# Functions declarations

update_packages(){
#Expect to receive an array with packages names
    echo "---Start packages update & install---"
    apt-get update -y
    apt-get install -y $@
    echo "---End packages update & install---"
}

update_python_libs(){
#Expect to receive an array with libs names
    echo "---Start install python libs---"
    pip install $@
    echo "---End install python libs---"
}

deploy_from_github(){
#Expect to receive: REPO to clone, USER and GROUP for the folder where app will deploy
    echo "---Start app deployment---"
    rm -rf $APP_DIR
    mkdir -p $APP_DIR
    git clone $1 $APP_DIR
    chown -R $2:$3 $APP_DIR
    echo "---End app deployment---"
}

create_aplicacion_service_file(){
    if [[ -a $APP_SERVICE_FILE ]]
        then
            rm $APP_SERVICE_FILE
    fi

    cat << EOF > $APP_SERVICE_FILE
[Unit]
Description=Una app para uWSGI
After=network.target

[Service]
User=mario
Group=www-data
WorkingDirectory=/opt/aplicacion
ExecStart=/usr/local/bin/uwsgi --ini /opt/aplicacion/aplicacion.ini --logto /opt/aplicacion/wsgi.log

[Install]
WantedBy=multi-user.target

EOF
}

create_aplicacion_ini_file(){
    if [[ -a $APP_INI_FILE ]]
        then
            rm $APP_INI_FILE
    fi
    cat << EOF > $APP_INI_FILE
[uwsgi]
module = runserver:app

master = true
processes = 5

socket = aplicacion2.sock
chmod-socket = 666
vacuum = true

die-on-term = true
EOF
}

create_nginx_conf_file(){
    if [[ -a $NGINX_CONF_FILE ]]
        then
            rm $NGINX_CONF_FILE
    fi
    cat << EOF > $NGINX_CONF_FILE
server {
    listen 80 default_server;
    server_name default;

    location / {
        include uwsgi_params;
        uwsgi_pass unix:/opt/aplicacion/aplicacion2.sock;
    }
}
EOF
}

cleanup_and_link(){
    if [[ -a $NGINX_SITES_ENABLED_DIR/default ]]
        then
            rm $NGINX_SITES_ENABLED_DIR/default
    fi
    if [[ -a $NGINX_SITES_ENABLED_DIR/aplicacion_web ]]
        then
            rm $NGINX_SITES_ENABLED_DIR/aplicacion_web
    fi

    ln -s $NGINX_CONF_FILE $NGINX_SITES_ENABLED_DIR
}

start_app(){
    systemctl stop aplicacion.service
    systemctl daemon-reload
    systemctl start aplicacion.service
    systemctl enable aplicacion.service
}

start_nginx(){
    systemctl restart nginx
}

main(){
    echo echo "___Start main___"
    update_packages ${PACKAGES[*]}
    update_python_libs ${PYTHON_LIBS[*]}
    deploy_from_github $REPO $USER $GROUP
    echo "___Creating files___"
    create_aplicacion_service_file
    create_aplicacion_ini_file
    create_nginx_conf_file
    echo "___Cleaning___"
    cleanup_and_link
    echo "___Staring services___"
    start_app
    start_nginx
    echo "___Finish main___"
}
# /Functions declarations

# Real work
main
exit 0
