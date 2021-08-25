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
sudo -u deploy echo '
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> .bashrc
sudo -u deploy $ curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash

exec $SHELL

sudo -u deploy read -p 'Ruby Version?: ' ruby_version
sudo -u deploy rbenv install $ruby_version
sudo -u deploy rbenv global $ruby_version

sudo -u deploy gem install bundler

sudo -u deploy apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo -u deploy sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger focal main > /etc/apt/sources.list.d/passenger.list'
sudo -u deploy apt update
sudo -u deploy apt install -y nginx-extras libnginx-mod-http-passenger
if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo -u deploy ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi
sudo -u deploy ls /etc/nginx/conf.d/mod-http-passenger.conf

sudo -u deploy vim /etc/nginx/conf.d/mod-http-passenger.conf
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
