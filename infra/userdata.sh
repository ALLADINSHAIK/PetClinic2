#!/bin/bash
# SSM user didn't start in home dir, so go there
cd
sudo yum update -y
sudo yum install docker containerd git screen -y
sleep 1
wget https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)
sleep 1
sudo mv docker-compose-$(uname -s)-$(uname -m) /usr/libexec/docker/cli-plugins/docker-compose
sleep 1
chmod +x /usr/libexec/docker/cli-plugins/docker-compose
sleep 5
systemctl enable docker.service --now
sudo usermod -a -G docker ssm-user
sudo usermod -a -G docker ec2-user
systemctl restart docker.service
docker pull karthik0741/images:petclinic_img
docker run -d -p 80:8080 docker.io/karthik0741/images:petclinic_img