FROM ubuntu

RUN apt-get update && apt-get install python3-pip sudo openssh-client -y
RUN pip3 install ansible

# create user + add to sudoers group
RUN useradd -m emiel && \
    echo "emiel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers


USER emiel
CMD "/bin/bash"
