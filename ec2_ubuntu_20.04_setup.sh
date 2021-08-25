#! /bin/bash


cd ~

rm -rfv ~/MyConfig ~/.bashrc ~/.bash_profile ~/.profile ~/.vim*
git clone git@github.com:StevenDRiggs/MyConfig.git
cp ~/MyConfig/.bashrc ~
cp ~/MyConfig/.vimrc ~

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c ':PluginInstall' -c ':q' -c ':q' ~/.vimrc
vim -c ':%s/"//' -c ':w' -c ':source %' -c ':PluginInstall' -c ':q' -c ':q' ~/.vimrc
vim -c ':%s/"//' -c ':w' -c ':q' ~/.vimrc

rm -rf MyConfig/

sudo apt upgrade -y && sudo apt update -y

git config --global color.ui true
git config --global user.name "StevenDRiggs"
git config --global user.email "sfriggs21@gmail.com"
git config --global submodule.recurse true

sudo adduser deploy
sudo adduser deploy sudo

sudo vim .ssh/authorized_keys

sudo -u deploy /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(sudo -u deploy $HOME/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
eval "$(sudo -u deploy $HOME/.linuxbrew/bin/brew shellenv)"

sudo apt install build-essential -y

sudo apt install apt-transport-https automake bison build-essential ca-certificates dirmngr g++ gcc gifsicle git-core gnupg jpegoptim libcurl4-openssl-dev libffi-dev libgdbm-dev libncurses5-dev libpq-dev libqt5webkit5-dev libreadline-dev libsqlite3-dev libssl-dev libtool libxml2-dev libxslt1-dev libyaml-dev make nodejs optipng postgresql postgresql-contrib qt5-default redis-server redis-tools ruby-dev software-properties-common sqlite3 tree yarn zlib1g-dev -y

sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install node
npm install -g npm
npm install -g yarn

sudo add-apt-repository ppa:redislabs/redis -y
sudo apt update
sudo apt install redis

sudo su deploy -c brew install rbenv -v
sudo su deploy -c rbenv init
sudo su deploy -c echo '
export PATH=\"$HOME/.rbenv/bin:$PATH\"
eval \"$(rbenv init -)\"
export PATH=\"$HOME/.rbenv/plugins/ruby-build/bin:$PATH\"' >> .bashrc
sudo -u deploy curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash

cat ~/.bash_profile >> ~/.bashrc
cat ~/.profile >> ~/.bashrc
cp ~/.bashrc ~/.bash_profile
cp ~/.bashrc ~/.profile
sudo su deploy -c exec $SHELL

read -p 'Ruby Version?: ' ruby_version
sudo su deploy -c rbenv install $ruby_version
sudo su deploy -c rbenv global $ruby_version

gem install bundler

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger focal main > /etc/apt/sources.list.d/passenger.list'
sudo apt update
sudo apt install -y nginx-extras libnginx-mod-http-passenger
if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi
sudo ls /etc/nginx/conf.d/mod-http-passenger.conf

sudo vim -c ":%s/passenger_free_ruby/$(which ruby | sed 's|\/|\\\/|g')/" -c "s/\/\//\//g" -c ":wq" /etc/nginx/conf.d/mod-http-passenger.conf
echo '
server {
  listen 80;
  listen [::]:80;

  server_name stevendriggs.com;
  root /home/deploy/aws_rails/current/public;

  passenger_enabled on;
  passenger_app_env production;

  location /cable {
    passenger_app_group_name aws_rails_websocket;
    passenger_force_max_concurrent_requests_per_process 0;
  }

  client_max_body_size 200m;

  location ~ ^/(assets|packs) {
    expires max;
    gzip_static on;
  }
}' | sudo tee /etc/nginx/sites-enabled/stevendriggs.com

sudo service nginx start

sudo apt autoremove
