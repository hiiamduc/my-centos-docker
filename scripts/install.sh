#!/bin/sh
echo ">> Install docker repo to repos list"
sudo yum -y -q install git curl
sudo cat <<-'EOF' >/etc/yum.repos.d/docker.repo
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

echo ">> Install and start docker service"
sudo yum -y -q install docker-engine
sudo service docker start
sudo systemctl enable docker.service
sudo usermod -aG docker vagrant

echo ">> Load docker images"
docker load -q -i /app/setup/images/nginx.tar.gz
docker load -q -i /app/setup/images/php.tar.gz
docker load -q -i /app/setup/images/redis.tar.gz
docker load -q -i /app/setup/images/mariadb.tar.gz

echo ">> Install docker-compose"
sudo curl -sSL https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
