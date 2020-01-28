#!/bin/sh

GOVERSION=1.13.3
GOTAR=go$GOVERSION.linux-amd64.tar.gz

sudo apt update                                                       # Make sure latest version is available.
wget https://dl.google.com/go/$GOTAR --directory-prefix=$HOME         # Get package.
sudo tar -C /usr/local -xzf $HOME/$GOTAR                              # Unpack at /usr/local
sudo rm -rf $HOME/$GOTAR                                              # Remove tar
mkdir -p ~/go/src                                                     # create default go projects directory
echo "export PATH=$PATH:/usr/local/go/bin" >> $HOME/.profile          # Add PATH variable
. $HOME/.profile                                                      # Source the file
go version                                                            # Get version to check if everything works

