# update & install docker
sudo yum update -y
sudo amazon-linux-extras install docker -y

# start docker service
sudo service docker start

# add user to docker group
sudo usermod -a -G docker ec2-user

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# install git
sudo yum install git -y
