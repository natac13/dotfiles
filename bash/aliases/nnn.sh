#!/bin/bash

export NNN_FIFO='/tmp/nnn.fifo'
# Block Device
# Char Device
# Directory
# Exectutable
# Regular
# Hard Link
# Symbolic link
# Missing or file details
# Orphaned symbolic link
# FIFO
# Socket
# Unknown or 0b regular/exe
export NNN_FCOLORS='c1e2512e006033f7c6d6abc4'
export NNN_PLUG='f:finder;o:fzopen;c:fzcd;g:-_git diff;'
# alias nnn='nn'

nn ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    # export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn -d "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
