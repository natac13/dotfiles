if _command_exists tldr; then
  complete -W "$(tldr 2>/dev/null --list)" tldr
fi

# color: Possible settings are: black, red, green, yellow, blue, magenta, cyan, white, onblue, ongrey, reset, bold, underline, italic, eitalic, default
export TLDR_HEADER='magenta bold underline'
export TLDR_QUOTE='italic'
export TLDR_DESCRIPTION='white'
export TLDR_CODE='yellow'
export TLDR_PARAM='blue'
