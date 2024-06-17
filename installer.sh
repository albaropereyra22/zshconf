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
WSL2=${WSL2%% *}

if [ "X$(uname -s)" = "XDarwin" ];
then
  # -s returns 0 if found otherwise 1
  which -s brew;
  # $? exit status of previous command
  if [ $? != 0 ];
  then
    # Install Homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)";
  fi
  brew update;
  brew upgrade;
  if [ ! -e /usr/local/Cellar/zsh ];
  then
    # Install zsh
    brew install zsh;
  fi
  git clone $repoUrl ${HOME}/${fileName};
  mv ${HOME}/${fileName}/.zshrc ${HOME}/.zshrc;
elif[ "X$WSL2" = "XWSL2" ];
  echo "WSL2"
fi
echo "$WSL2"
if [ ! -e ${HOME}/.oh-my-zsh ];
then
  # Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
fi

# git clone $repoUrl ${HOME}/${fileName};
# mv ${HOME}/${fileName}/.zshrc ${HOME}/.zshrc;
# touch $personalZshrcFile
# rm -rf ${HOME}/${fileName};
printf "ZSH conf has been updated.\n";
