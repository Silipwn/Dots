#!/usr/bin/env bash
# SPDX-License-Identifier: BSD-3-Clause or GPL-3.0-or-later
# SPDX-FileCopyrightText: (C) 2022 silipwn (Ashwin)
# Finis coronat opus; Run at this code at your own peril ~ silipwn;
# File                   : one_ring.sh
# Author                 : silipwn <contact at as-hw.in>
# Description            : One Ring to rule them all, One Ring to find them, One Ring to bring them all and in the darkness bind them. 
# Date                   : 2022-04-11T11:59:22-0400
# Last-Modified          : 2022-11-01T14:10:18-0400
# Idea for now is to have a bash script with some stuff to do things
set -eo pipefail

# Check if the system has apt
if ! [ -x "$(command -v apt)" ]; then
  echo "This script currently only supports deb based systems." >&2
  exit 1
fi
# ref: https://askubuntu.com/a/30157/8698
if ! [ $(id -u) = 0 ]; then
   echo "This script probably needs to be run as root." >&2
   exit 1
fi

# Bash function to get the release based on the string provided
function get_deb () {
URL_PRE=https://api.github.com/repos/
URL_POST=/releases/latest
URL=$URL_PRE$1$URL_POST
curl -s $URL \
          | grep "browser_download_url.*amd64.*deb" \
          | cut -d : -f 2,3 \
          | tr -d \" \
          | wget -qi -

}
# List of packages to install
# This is a list of packages to install on any *nix system
# Terminal
# - git
# - tmux
# - vim
# - ssh 
# - htop
sudo apt-get -y update
sudo apt-get install -y git tmux vim openssh-server curl build-essentials software-properties-common jq htop wget
# Python
sudo apt-get install -y python3-pip python3-dev python3-setuptools
# - fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
# - fd
# - rg
# - bat
# - delta
# - dust
get_deb(sharkdp/fd)
get_deb(dandavison/delta)
get_deb(sharkdp/bat)
get_deb(bootandy/dust)
sudo dpkg -i *.deb
rm *.deb
# - exa
sudo apt-get install -y exa
# https://jvns.ca/blog/2022/04/12/a-list-of-new-ish--command-line-tools/
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
echo ". $HOME/.asdf/asdf.sh" >> $HOME/.bashrc
    # - node
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    # - python
asdf plugin-add python
asdf python global system 
# Change shell
pip install ranger-fm
# Install
# Clone dots
# Setup the vim dirs
mkdir -p $HOME/.vim/files/backup/ $HOME/.vim/files/swap/ $HOME/.vim/files/undo/ $HOME/.vim/plugins/
# Git clone
git clone https://github.com/ojroques/vim-oscyank $HOME/.vim/plugins/vim-oscyank
git clone https://github.com/Silipwn/vim-header $HOME/.vim/plugins/vim-header
# Let's get the dots
# Vim config
wget https://raw.githubusercontent.com/Silipwn/Dots/chezmoi/dot_vimrc -O $HOME/.vimrc
# Tmux config
wget https://raw.githubusercontent.com/Silipwn/Dots/chezmoi/dot_tmux.conf -O $HOME/.tmux.conf
# TPM
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
# Git config
