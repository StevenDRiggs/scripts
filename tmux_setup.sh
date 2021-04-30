#! /data/data/com.termux/files/usr/bin/bash


rm -rfv ~/MyConfig ~/.bashrc ~/.bash_profile ~/.profile ~/.vim*
touch ~/.bash_profile

#pkg upgrade -y && pkg update -y
#pkg install curl git libyaml libxml2 libffi automake libtool bison gnupg postgresql man openssh nodejs clang -y

#npm install -g npm
#
#export PATH="$HOME/.rbenv/bin:$PATH"
#curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
#mkdir -p "$(rbenv root)"/plugins
#rbenv init
#curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
#
read -p 'GitHub username?: ' gh_username < /dev/tty
#read -p 'Email?: ' email < /dev/tty
#git config --global color.ui true
#git config --global user.name $gh_username
#git config --global user.email $email
git clone https://github.com/$gh_username/MyConfig.git ~/MyConfig
#cat ~/MyConfig/tmux_bash >> ~/.bash_profile
#
#cd
#source ~/.bash_profile
#
#rbenv install -v 2.5.7
#rbenv install -v 3.0.0
#rbenv global 3.0.0
#
#gem install bundler rails
#
#pkg install python -y
#pip install --upgrade pip
#pip install virtualenv
#
#pkg install vim -y
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp ~/MyConfig/.vimrc ~
vim -c ':PluginInstall' -c 'q' -c ':%s/^"//' -c ':wq' ~/.vimrc
vim -c ':PluginInstall' -c 'q' -c ':%s/^"//' -c ':%s/^"//' -c ':wq' ~/.vimrc

rm -rf MyConfig/
