# Albaro's .zshrc conf file

# Use emacs to uncomment commented out code (ex. #,# #)
# Select the region with Ctl + Space Bar
# Then you can even use the arrow keys
# To end region selection press Ctl + Space Bar again
# The comment toggle shortcut is alt/option + ;

# If your are really serious about development.
# The Kinesis Advantage 2 keyboard is recommended.
# I personally bought the Kinesis Advantage 2 QD
# The foot pedal might be a good option, to fool
# micro managers.  I never got around getting it.

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh;

# Update every 24hours
export HOMEBREW_AUTO_UPDATE_SECS="86400";

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# This is a nice theme, with a time stamp and git info
export ZSH_THEME="ys";

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true";

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true";

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true";

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy";

# You may manually need to set the LANG var
export LANG="en_US.UTF-8";
export MAILDIR="/var/mail/$(whoami)";
export TMPDIR="$HOME/tmp";
# If this is not set zenburn looks funny.
export TERM=xterm-256color;

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git);

source $ZSH/oh-my-zsh.sh;


# Personal favorites
alias ls="ls -GlAhF";

function cd {
  # if cd does not have an argument its default behaviour is to, go home
  if [ -z "$1" ];
  then
    builtin cd ~ && ls -GlAhF;
  else
    builtin cd $* && ls -GlAhF;
  fi
}

# #MAC OSX settings

# Only root has access to manipulate the httpd process.
alias httpd="sudo httpd";
# The following requires installation of drogon
alias dg="drogon_ctl";


# # Make ifconfig more Windows-e
# # The function asumes the user is usig DHCP.
# function ifconfig {
#   networkInterface=$(netstat -i | grep -E "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" | head -1 | awk '{printf "%s" ,$1}');
#   # if ifconfig does not have an argument diplay only important information.
#   if [ -z "$1" ] && [ -n "$networkInterface" ];
#   then
#     /sbin/ifconfig $networkInterface inet | grep inet |sed -r 's/^[[:blank:]]+//' | awk '{ printf "%-19s %s\n%-19s ", "IPv4 Address:", $2, "Subnet Mask:" }';
#     ipconfig getoption $networkInterface subnet_mask;
#     printf "%-19s " "Default Gateway:";
#     ipconfig getoption $networkInterface router;
#   else
#     /sbin/ifconfig $*;
#   fi
# }

# # FreeBSD Settings

# #add some color to the terminal
# export CLICOLOR=1
# export LSCOLORS=GxFxCxDxBxegedabagaced

# # The following setting need special requirements

# # pkg install emacs25 | apt-get install emacs | brew install emacs
export EDITOR="emacs";
alias e="emacs";
# # pkg install bat | apt-get install bat | brew install bat
# # Notice: bat does not include cat's -v option, you may
# # have to use hexdump to find invisible charaters.
alias cat="bat"

# Functions and hacks from the GNU essentials book
# https://shop.fsf.org/books-docs/introduction-command-line

# Type the name of the directory to change to that directory
# $/opt to run $cd /opt
setopt autocd autopushd

# Changes to the previous directory d to display recently visited directorie
# ex. $d;2
alias d='dirs -v | head -10'

# Used to compare emacs backup files
function d~ {
  # Compare the Emacs back-up version with the current version.
  diff -u $1~ $1 | less
}
# Used to check spelling. 
function orth () {
  echo $* | ispell;
}

# I use this file to keep personal information such as HOMEBREW_API_TOKEN
# as well as aliases to ssh into other hosts.
#source .personalZshrc
# At the very end I execute a script.
#sh ~/bin/startCLI.sh
