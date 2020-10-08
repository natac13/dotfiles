#!/bin/bash

# alias xclip to systemwide clipboard if installed
if type xclip &> /dev/null
then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi
