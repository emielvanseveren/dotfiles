# /bin/bash

apt update
apt install curl -y
apt install sudo -y

# create new user 
useradd emiel -p 123 --create-home -g sudo



