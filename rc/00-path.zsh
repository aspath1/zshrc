# -*- sh -*-

# Nix stuff
[[ -d $HOME/.nix-defexpr/channels/nixpkgs ]] && {
    [[ -n $NIX_PATH ]] || \
        export NIX_PATH=nixpkgs=$HOME/.nix-defexpr/channels/nixpkgs
    [[ -n $NIX_SSL_CERT_FILE ]] || \
        export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
}

() {
    local -a wanted savedpath
    local p
    wanted=(~/bin ~/.nix-profile/bin /usr/lib/ccache
            /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
            /usr/local/games /usr/games)
    savedpath=($path)
    path=()
    for p in $savedpath; do
	(( ${${wanted[(r)$p]}:+1} )) || (( ${${path[(r)${p:A}]}:+1} )) || {
	    [ -d ${p:A} ] && path=($path $p)
	}
    done
    for p in $wanted; do
	(( ${${path[(r)${p:A}]}:+1} )) || {
	    [ -d ${p:A} ] && path=($path $p)
	}
    done
}
