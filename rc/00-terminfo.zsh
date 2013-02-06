# -*- sh -*-

# Update terminfo
__() {
    local terminfo
    local termpath
    for terminfo in $ZSH/terminfo/*.terminfo(.N); do
	# We assume that the file is named appropriately for this to work
	termpath=~/.terminfo/${(@)${terminfo##*/}[1]}/${${terminfo##*/}%%.terminfo}
	if [[ ! -e $termpath ]] || [[ $terminfo -nt $termpath ]]; then
	    TERMINFO=~/.terminfo tic $terminfo
	fi
    done
} && __

# Update TERM if we have LC__ORIGINALTERM variable
# Also, try a sensible term where we have terminfo stuff
autoload -U colors zsh/terminfo
__() {
    local term
    for term in $LC__ORIGINALTERM $TERM ${TERM/-256color} xterm-256color xterm; do
        TERM=$term 2> /dev/null
        [[ "$terminfo[colors]" -ge 8 ]] && {
            colors
            break
        }
    done
    unset LC__ORIGINALTERM
    export TERM
} && __
