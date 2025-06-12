#! /bin/sh -

if [ "X-h" = "X$1" ];
then
  tee<<EOF;
usage: $0 h:
EOF
  exit 0;
fi

# Variables
repoUrl="https://github.com/albaropereyra22/zshconf";
fileName=${repoUrl##*/};
personalZshrcFile="${HOME}/.personalZshrc";
uname=$(uname -r)
WSL2=${uname##*-}

git clone $repoUrl ${HOME}/${fileName};
if [ "X$(uname -s)" = "XDarwin" ];
then
  # -s returns 0 if found otherwise 1
  which -s brew;
  # $? exit status of previous command
  if [ "X1" = "X$?" ];
  then
    # Install Homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  brew update;
  brew upgrade;
  if [ ! -e /usr/local/Cellar/zsh ];
  then
    # Install zsh
    brew install zsh;
  fi
  mv ${HOME}/${fileName}/.zshrc ${HOME}/.zshrc;
elif [ "X$WSL2" = "XWSL2" ];
then
  sudo apt-get updates;
  sudo apt-get upgrade;
  sudo apt install bat;
  mv ${HOME}/${fileName}/.zshrc$WSL2 ${HOME}/.zshrc;
  
fi
touch $personalZshrcFile
rm -rf ${HOME}/${fileName};
if [ ! -e ${HOME}/.oh-my-zsh ];
then
  # Install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
fi

printf "ZSH conf has been updated.\n";
