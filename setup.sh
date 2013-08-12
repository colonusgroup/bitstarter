#!/bin/bash

clear

echo "[1/9] Running update..."
sudo apt-get update -y

echo "[2/9] Installing  Node Version Manager..."
sudo apt-get install -y git curl
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

echo "[3/9] Loading and updating nvm..."
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

echo "[4/9] Installing jshint globally..."
npm install -g jshint

echo "[5/9] Installing rlwrap..."
sudo apt-get install -y rlwrap

echo "[6/9] Installing emacs from https://launchpad.net/~cassou/+archive/emacs ..."
sudo apt-add-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

echo "[7/9] Install Heroku Toolbelt..."
wget -q0- https://toolbelt.heroku.com/install-ubuntu.sh | sh

echo "[8/9] Configuring git and  dotfiles..."
git config --global user.name "Colonus Group"
git config --global user.email "colonusgroup@gmail.com"
mkdir bitstarter
cd bitstarter
git init
git remote add origin git@github.com:colonusgroup/bitstarter.git

cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/startup-class/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sf dotfiles/.emacs.d .

echo "[9/9] Installing remaining packages etc..."

sudo apt-get install -y python-software-properties python g++ nodejs make

echo "Done with Setup!"
