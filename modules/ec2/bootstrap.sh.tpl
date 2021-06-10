#!/bin/bash

function create_new_user(){
adduser ${USER}
sudo usermod -aG wheel ${USER}
mkdir -p /home/${USER}/.ssh/
sudo cp ~/.ssh/authorized_keys /home/${USER}/.ssh/authorized_keys
}

function permit_root_login(){
ROOT_LOGIN=$(sudo cat /etc/ssh/sshd_config | grep PermitRootLogin | awk '{print $1}'| head -n 1)
if [[ $ROOT_LOGIN == "#PermitRootLogin" ]]; then
  echo "Root login disabled"
else
  sudo sed -i 's/PermitRootLogin yes/#PermitRootLogin yes/g' /etc/ssh/sshd_config
  sudo systemctl restart sshd
  permit_root_login
fi
}
function update_port(){
sudo sed -i 's/#Port 22/Port 2222/g' /etc/ssh/sshd_config
}

function check_port(){
NEW_PORT=$(sudo netstat -tulpn | grep sshd | awk '{print $4}' | head -n 1 | cut -f2 -d":")
if [[ $NEW_PORT == "2222" ]]; then
 echo "Port updated successfully"
 sudo semanage port -a -t ssh_port_t -p tcp 2222
 sudo systemctl restart sshd
 exit 0;
fi
}

function install_netdata(){
  yum -y install epel-release -y
  yum repolist
  sudo yum install zlib-devel libuuid-devel libmnl-devel gcc make git autoconf autogen automake pkgconfig libuv-devel -y
  sudo yum install curl jq nodejs -y
  bash <(curl -Ss https://my-netdata.io/kickstart.sh)
  sudo yum install psmisc -y
  sudo killall netdata
  sudo cp ~/netdata/system/netdata.service /etc/systemd/system/
  sudo systemctl daemon-reload
  sudo systemctl start netdata.service
  sudo systemctl enable netdata.service
}

function install_nginx(){
  sudo yum install nginx -y
  sudo systemctl start nginx
  sudo systemctl enable nginx
  sudo touch /etc/nginx/conf.d/default.conf
  cat >>/etc/nginx/conf.d/default.conf <<EOF
server {
  listen       80;
  server_name  localhost;

  location / {
      root   /usr/share/nginx/html;
      index  hellosky.html;
  }
}
EOF
  cat >>/usr/share/nginx/html/hellosky.html <<EOF
<html>
  <head>
      <title>Hello Sky!</title>
  </head>
  <body>
      <h1>Hello Sky!</h1>
  </body>
</html>
EOF
  sudo nginx -t
  sudo service nginx reload
}


create_new_user
permit_root_login
update_port
check_port
install_netdata
install_nginx