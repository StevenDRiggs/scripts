#! /data/data/com.termux/files/usr/bin/bash


pkg upgrade -y && pkg update -y
pkg upgrade -y && pkg update -y
pkg install curl -y

read -p 'Email?: ' email
read -p 'GitHub username?: ' gh_username
git config --global color.ui true
git config --global user.name $gh_username
git config --global user.email $email

pkg install libyaml libxml2 libffi automake libtool bison gnupg postgresql -y

ssh -T git@github.com

git clone git@github.com:$gh_username/MyConfig.git ~/MyConfig
cp ~/MyConfig/tmux_bash ~/.bash_profile
cp ~/MyConfig/tmux_bash ~/.bashrc
cp ~/MyConfig/tmux_bash ~/.profile

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src

cd
cp ~/MyConfig/tmux_bash ~/.bash_profile
source ~/.bash_profile

nvm install node
npm install -g npm

curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
rbenv install 2.5.7
rbenv global 2.5.7

gem install bundler rails

pkg install python -y
pip install --upgrade pip
pip install virtualenv

pkg install vim -y
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp ~/MyConfig/.vimrc ~
vim -c ':PluginInstall' -c ':q' -c ':q' .vimrc
vim -c ':%s/"//' -c ':w' -c ':source %' -c ':PluginInstall' -c ':q' -c ':q' .vimrc
vim -c ':%s/"//' -c ':w' -c ':q' .vimrc

rm -rf MyConfig/
