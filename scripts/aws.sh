#!/bin/bash

if ! _command_exists aws; then
  cd $HOME/Downloads/
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
fi

echo 'Install cloudformation linter cfn-lint with pip3 or pip...'
if _command_exists pip3; then
  echo 'Using pip3'
  pip install cfn-lint
elif _command_exists pip; then
  echo 'Using pip'
  pip install cfn-lint
else
  echo 'No pip3 or pip avaiable to install cfn-lint'
fi
