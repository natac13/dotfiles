#!/bin/bash

#####################################################
# AWS
#####################################################

alias daws='docker container run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli'
alias aws-shell='docker run -v ~/.aws:/root/.aws -it pahud/aws-shell'
