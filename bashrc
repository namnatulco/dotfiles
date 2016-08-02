# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=erasedups:ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=20000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto -n'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export LANG=en_US.UTF-8

#do not save boring two-symbol commands like ls, ps in history
HISTIGNORE='??'

# connection script so I don't have to remember the ssh switches
function proxyconnect(){
  TMP="`ps aux | grep 'ssh -D 8080 -f -N -q' | cut -d'q' -f2`"
  if [ ! -z "$TMP" ]; then
    echo "Warning, tunnel already active (to$TMP)!"
    echo "PID: `ps aux | grep 'ssh -D 8080 -f -N -q' | grep -v 'grep' | cut -d' ' -f2-3`"
    #note: cut by ' ', because grep converts tabs into spaces, and -f2-3 because the amount of spaces seems to vary
    return;
  fi
	if [ -z "$1" ];
	then
		echo "connecting to namnatulco.eu..."
		ssh -D 8080 -f -N -q namnatulco.eu
	else
		echo "connecting to $1..."
		ssh -D 8080 -f -N -q "$1"
	fi
  if [ "$?" -ne 0 ]; then
    echo "ssh returned non-zero status code"
  fi
}

export OLD_PATH=$PATH
export OLD_LD_LIBRARY_PATH=$LD_LIBRARY_PATH

function opp46(){
  #add current directory and OMNeT++ binary folder to $PATH
  export PATH=$OLD_PATH:~/simulation/omnetpp-4.6/bin:.
  #add omnet++ libs to library path
  export LD_LIBRARY_PATH=$OLD_LD_LIBRARY_PATH:~/simulation/omnetpp-4.6/lib
}

function opp50(){
  #add current directory and OMNeT++ binary folder to $PATH
  export PATH=$OLD_PATH:~/simulation/omnetpp-5.0/bin:.
  #add omnet++ libs to library path
  export LD_LIBRARY_PATH=$OLD_LD_LIBRARY_PATH:~/simulation/omnetpp-5.0/lib
}

opp46

#make a cool function for debugging a running process
#argument is the pid
gdn(){ gdb -n /proc/$1/exe $1; }

#get vi keybindings
#set -o vi
#not necessary, since it is already configured in inputrc

export EDITOR=/usr/bin/vim
