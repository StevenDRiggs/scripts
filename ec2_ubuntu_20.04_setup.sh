#! /bin/bash


cd ~

rm -rfv ~/MyConfig ~/.bashrc ~/.bash_profile ~/.profile ~/.vim*
touch ~/.bashrc

sudo apt upgrade -y && sudo apt update -y

git config --global color.ui true
git config --global user.name "StevenDRiggs"
git config --global user.email "sfriggs21@gmail.com"
git config --global submodule.recurse true

sudo adduser deploy
sudo adduser deploy sudo

sudo -u deploy vim .ssh/authorized_keys

sudo -u deploy /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sudo -u deploy echo 'eval "$($HOME/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
sudo -u deploy eval "$($HOME/.linuxbrew/bin/brew shellenv)"

sudo -u deploy apt install build-essential -y

sudo -u deploy apt install apt-transport-https automake bison build-essential ca-certificates dirmngr g++ gcc gifsicle git-core gnupg jpegoptim libcurl4-openssl-dev libffi-dev libgdbm-dev libncurses5-dev libpq-dev libqt5webkit5-dev libreadline-dev libsqlite3-dev libssl-dev libtool libxml2-dev libxslt1-dev libyaml-dev make nodejs optipng postgresql postgresql-contrib qt5-default redis-server redis-tools ruby-dev software-properties-common sqlite3 yarn zlib1g-dev -y

sudo -u deploy curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
sudo -u deploy export NVM_DIR="$HOME/.nvm"
sudo -u deploy [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
sudo -u deploy [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
sudo -u deploy nvm install node
sudo -u deploy npm install -g npm
sudo -u deploy npm install -g yarn

sudo -u deploy add-apt-repository ppa:redislabs/redis -y
sudo -u deploy apt update
sudo -u deploy apt install redis

sudo -u deploy brew install rbenv -v
sudo -u deploy rbenv init
#echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
#curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
#rbenv install 2.5.7
#rbenv global 2.5.7
#
#gem install bundler rails
#
#brew install python3
#pip3 install virtualenv
#
#cd ~
#git clone git@github.com/$gh_username/MyConfig.git
#cp ~/MyConfig/.bash_profile ~
#cp ~/MyConfig/.bashrc ~
#cp ~/MyConfig/.profile ~
#cp ~/MyConfig/.vimrc ~
#source ~/.bash_profile
#
#sudo -u deploy apt install vim -y
#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#vim -c ':PluginInstall' -c ':q' -c ':q' .vimrc
#vim -c ':%s/"//' -c ':w' -c ':source %' -c ':PluginInstall' -c ':q' -c ':q' .vimrc
#vim -c ':%s/"//' -c ':w' -c ':q' .vimrc
#
#rm -rf MyConfig/
