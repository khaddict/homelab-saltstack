[ -z "$PS1" ] && return

HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
export HISTTIMEFORMAT="%Y/%m/%d %T "
export HISTSIZE=5000
export HISTFILESIZE=5000

shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

function rc {
    [[ $? -eq 0 ]] && echo -e "\e[01;34m" || echo -e "\e[01;31m"
}

function parse_git_branch {
    git branch 2>/dev/null | grep '\*' | sed 's/* \(.*\)/ (\1)/'
}

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    colour_prompt=yes
else
    colour_prompt=no
fi

if [ "$colour_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\e[1;32m\]\u\[\e[00m\]@\[\e[1;32m\]\h\[\e[00m\]:\[\e[01;34m\]\w\[\e[00m\]\[\e[01;33m\]$(parse_git_branch)\[\e[00m\] \[$(rc)\]\$\[\e[0m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi
unset colour_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias ip='ip --color=auto'
    alias diff='diff --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi