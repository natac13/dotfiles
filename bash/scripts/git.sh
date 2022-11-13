#!/bin/bash

DEFAULT='y'

source ~/.bash_profile # adds terminal color variables

printf "${IBlue}Would you like to create an ssh key for GitHub?${Color_Off} [Y/n]"
read gen_ssh
gen_ssh=${gen_ssh:-${DEFAULT}}
case $gen_ssh in
  [Yy]* )
    read -p "What email are you using for Github?: " email
    printf "${IBlue}Using email: ${Color_Off} $email\\n"
    if [ ! -f !/.ssh/github_rsa ]; then
      ssh-keygen -t rsa -b 4096 -C "$email" -f "$HOME/.ssh/github_rsa" -q -N ""
      ssh-add ~/.ssh/github_rsa
    fi
    pub=`cat ~/.ssh/github_rsa.pub`
    xclip -sel clip < ~/.ssh/github_rsa.pub
    printf "${IGreen}✓${Color_Off} The GitHub SSH key has been copied to your clipboard: \\n"
    printf "Opening GitHub setting...\\n"
    printf "Paste the SSH key and give it a descriptive Title.\\n"
    xdg-open "https://github.com/settings/ssh/new" > /dev/null 2>&1
    printf "\\n"
    ;;
  [Nn]* );;
  * )
esac

printf "${IBlue}Would you like to install gh GitHub's command line tool?${Color_Off} [Y/n]"
read igh
igh=${igh:-${DEFAULT}}
case $igh in
  [Yy]* )
    printf "Installing gh...\\n"
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
    sudo apt-add-repository https://cli.github.com/packages
    sudo apt update
    sudo apt install gh
    printf "${IGreen}✓${Color_Off}"
    printf "Login to gh.\\n"
    gh auth login
    gh config set editor nvim
    gh config set prompt enabled
    gh config set git_protocol https
    ;;
  [Nn]* );;
  * )
esac

