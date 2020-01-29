#!/bin/sh

# interesting tutorial - https://octetz.com/docs/2019/2019-04-24-vim-as-a-go-ide
# required: YARN (coc-plugin)

GOVERSION=1.13.3
GOTAR=go$GOVERSION.linux-amd64.tar.gz

sudo apt update                                                       # Make sure latest version is available.
wget https://dl.google.com/go/$GOTAR --directory-prefix=$HOME         # Get package.
sudo tar -C /usr/local -xzf $HOME/$GOTAR                              # Unpack at /usr/local
sudo rm -rf $HOME/$GOTAR                                              # Remove tar
mkdir -p ~/go/src                                                     # create default go projects directory
echo "export PATH=$PATH:/usr/local/go/bin" >> $HOME/.profile          # Add PATH variable
echo "export GOPATH=$HOME/go" >> $HOME/.profile                       #
echo "export GOBIN=$HOME/go/bin" >> $HOME/.profile                    #
echo "export PATH=$PATH:$GOBIN" >> $HOME/.profile                      #



ln -s "$(pwd)/vim/coc-settings.json" "$HOME/.vim/coc-settings.json"   # symbolic link for code completion languageserver settings.



source $HOME/.profile                                                 # Source the file
go env                                                                # Check if everything is set correctly
go version                                                            # Show go version

vim +GoInstallBinaries
