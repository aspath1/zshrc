# -*- sh -*-

setopt rmstarsilent             # Don't ask for confirmation on rm *
setopt interactivecomments	# Allow comments inside commands
setopt autopushd		# Maintain directories in a heap
setopt autocd			# Don't need to use `cd`
setopt extendedglob             # Enable extended globbing

# meta-h will invoke man for the current command
autoload run-help

# No timeout
unset TMOUT

# Remove / from WORDCHARS (more like bash)
WORDCHARS=${WORDCHARS:s#/#}

# Debian email address
[[ $USER != "bernat" ]] || export DEBEMAIL=bernat@debian.org
