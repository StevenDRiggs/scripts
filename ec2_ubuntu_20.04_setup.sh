#! /bin/bash


cd ~

rm -rfv ~/.bashrc ~/.bash_profile ~/.profile ~/.vim*

read -p 'git username?: ' git_username
read -p 'git email?: ' git_email
git config --global color.ui true
git config --global user.name $git_username
git config --global user.email $git_email
git config --global submodule.recurse true

# sudo vim .ssh/authorized_keys

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


sudo apt install build-essential -y

sudo apt install apt-transport-https automake bison ca-certificates dirmngr g++ gcc gifsicle git-core gnupg jpegoptim libcurl4-openssl-dev libffi-dev libgdbm-dev libncurses5-dev libpq-dev libqt5webkit5-dev libreadline-dev libsqlite3-dev libssl-dev libtool libxml2-dev libxslt1-dev libyaml-dev make nodejs optipng qt5-default redis-server redis-tools ruby-dev software-properties-common sqlite3 tree yarn zlib1g-dev -y
# sudo apt install postgresql postgresql-contrib

brew install postgresql

sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install node
npm install -g npm
npm install -g yarn
yarn global add typescript @types/jest

sudo add-apt-repository -y ppa:redislabs/redis
sudo apt update -y && sudo apt upgrade -y
sudo apt install redis -y

brew install rbenv -v
rbenv init
echo '
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - bash)"
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

git clone https://github.com/StevenDRiggs/MyConfig.git
cat ~/MyConfig/.bashrc >> ~/.bashrc
cat ~/MyConfig/.bashrc >> ~/.bash_profile
cat ~/MyConfig/.bashrc >> ~/.profile

cp ~/MyConfig/.vimrc ~
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c ':PluginInstall' -c ':qa' ~/.vimrc
vim -c ':%s/"//' -c ':w' -c ':source %' -c ':PluginInstall' -c ':qa' ~/.vimrc
vim -c ':%s/"//' -c ':wq' ~/.vimrc

rm -rf MyConfig/

source ~/.bashrc

read -p 'Ruby Version? (Enter for default 3.0.2): ' ruby_version
if [[ ${#ruby_version} -eq 0 ]]; then
	ruby_version=3.0.2
fi
rbenv install $ruby_version -v
rbenv global $ruby_version

gem install bundler rails rspec rspec-rails

read -p 'Python Version? (Enter for default 3.9): ' python_version
if [[ ${#python_version} -eq 0 ]]; then
	python_version=3.9
fi
brew install python@$python_version

cd ~

pip3 install pip virtualenv

sudo apt update -y && sudo apt upgrade -y

sudo apt autoremove -y

exec $SHELL
