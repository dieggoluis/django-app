# update & install docker
sudo yum update -y
sudo amazon-linux-extras install docker -y

# start docker service
sudo service docker start

# add user to docker group
sudo usermod -a -G docker $USER

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# install git
sudo yum install git -y

# clone git repo
git clone https://github.com/dieggoluis/django-app.git

# replace local ip
PUBLIC_IP=`curl http://checkip.amazonaws.com`
sed -i "s/127.0.0.1/$PUBLIC_IP/g" django-app/web/web/settings.py

# run docker compose
newgrp docker << END
docker-compose -f django-app/docker-compose.yml up -d --build
END
