#! /data/data/com.termux/files/usr/bin/bash


cd ~

rm -rfv ~/.bashrc ~/.bash_profile ~/.profile ~/.vim*

read -p 'git username?: ' git_username
read -p 'git email?: ' git_email
git config --global color.ui true
git config --global user.name $git_username
git config --global user.email $git_email
git config --global submodule.recurse true

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$($HOME/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
eval "$($HOME/linuxbrew/.linuxbrew/bin/brew shellenv)"

pkg install -y build-essential

pkg install -y automake bison ca-certificates clang gifsicle gnupg jpegoptim libffi libllvm libtool libxml2 libyaml make man nodejs openssh optipng ruby tree yarn
# pkg install postgresql

brew install postgresql

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install node
npm install -g npm
npm install -g yarn
yarn global add typescript @types/jest

brew install rbenv -v
rbenv init
echo '
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> .bash_profile
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash

cat ~/.bash_profile >> ~/.bashrc
cat ~/.profile >> ~/.bashrc

echo "
# If not running interactively, don't do anything
case \$- in
    *i*) ;;
      *) return;;
esac" >> ~/.bashrc

cp ~/.bashrc ~/.bash_profile
cp ~/.bashrc ~/.profile

echo "
echo '.bashrc called'
" >> ~/.bashrc

echo "
echo '.bash_profile called'
" >> ~/.bash_profile

echo "
echo '.profile called'
" >> ~/.profile

git clone git@github.com:StevenDRiggs/MyConfig.git
cat ~/MyConfig/.bashrc >> ~/.bashrc
cat ~/MyConfig/.bashrc >> ~/.bash_profile
cat ~/MyConfig/.bashrc >> ~/.profile

cp ~/MyConfig/.vimrc ~
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c ':PluginInstall' -c ':qa' ~/.vimrc
vim -c ':%s/"//' -c ':w' -c ':source %' -c ':PluginInstall' -c ':qa' ~/.vimrc
vim -c ':%s/"//' -c ':wq' ~/.vimrc

rm -rf MyConfig/

exec $SHELL

read -p 'Ruby Version?: ' ruby_version
rbenv install $ruby_version -v
rbenv global $ruby_version

gem install bundler rails rspec rspec-rails

curl https://www.python.org/ftp/python/3.9.9/Python-3.9.9.tgz --output Python-3.9.9.tgz
tar -xf ./Python-3.9.9.tgz
cd Python-3.9.9.tgz
./configure
make altinstall

cd ~

pkg autoremove -y
