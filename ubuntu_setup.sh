#! /bin/bash


rm -rfv ~/MyConfig ~/.bashrc ~/.bash_profile ~/.profile ~/.vim*
touch ~/.bashrc

sudo apt upgrade -y && sudo apt update -y

read -p 'GitHub username?: ' gh_username
read -p 'Email?: ' email
git config --global color.ui true
git config --global user.name $gh_username
git config --global user.email $email
git config --global submodule.recurse true

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ~/.bashrc
source ~/.bashrc
sudo apt install build-essential -y
brew install gcc

sudo apt install zlib1g-dev libssl-dev libreadline-dev libyaml-dev libsqlite3-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev libpq-dev libgdbm-dev libncurses5-dev automake libtool bison gnupg postgresql postgresql-contrib -y
# pg_ctlcluster 12 main start

#curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
#source ~/.bashrc
#nvm install node
#npm install -g npm
#
#brew install rbenv
#rbenv init
#echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
#source ~/.bash_profile
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
#sudo apt install vim -y
#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#vim -c ':PluginInstall' -c ':q' -c ':q' .vimrc
#vim -c ':%s/"//' -c ':w' -c ':source %' -c ':PluginInstall' -c ':q' -c ':q' .vimrc
#vim -c ':%s/"//' -c ':w' -c ':q' .vimrc
#
#rm -rf MyConfig/
