FROM debian
RUN apt-get update
RUN apt-get install curl sudo -y

# create user + add to sudoers group
RUN useradd -m emiel && \
    echo "emiel ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Replace sh with bash so we can source files.
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

COPY . /opt/dots
WORKDIR  /opt/dots
USER emiel

CMD ["./setup.sh"]
