function _success () {
  printf "${IGreen} ✔ ${Color_Off} $1\\n"
}

function _fail () {
  printf "${IRed} ✖ ${Color_Off} $1\\n"
  # exit 1
}

function _doing () {
  printf "${IYellow} ➜ ${Color_Off} $1...\\n"
}

function _info () {
  printf "${IBlue} ℹ ${Color_Off} $1\\n"
}

function _command_exists ()
{
  # _info 'checks for existence of a command'
  # _info '1: command to check'
  # _info '2: (optional) log message to include when command not found'
  # _info '$ _command_exists ls && echo exists'
  # _info 'lib'
  local msg="${2:-Command '$1' does not exist!}"
  type "$1" &> /dev/null || (_fail "$msg" && return 1) ;
}
