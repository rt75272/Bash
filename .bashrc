# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -al'
alias la='ls -A'
alias l='ls -CF'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Added aliases
alias brave="nohup brave-browser&>/dev/null &"
alias google-chrome="nohup google-chrome&>/dev/null &"
alias vivaldi="nohup vivaldi&>/dev/null &"
alias zoom="nohup zoom&>/dev/null &"

alias python="python3.11"
alias new="clear && cd ~"
alias update="
    sudo apt update
    sudo apt -y upgrade
    sudo apt -y autoremove"
    # conda update conda --all --yes
    # conda update anaconda --all --yes"
alias sysinfo="screenfetch"
alias fortune="fortune | lolcat"
alias gitpw="mcrypt --decrypt /home/bob/Bash/git_psswrd.txt.nc && xclip -sel clip /home/bob/Bash/git_psswrd.txt && rm /home/bob/Bash/git_psswrd.txt"
# alias matlab="
#     echo matlab .
#     matlab . &"
alias darken="redshift -O 6500k -b 0.9"
alias lighten="redshift -x"
alias gitreset="git reset --soft HEAD~1"
alias bedtime="
    cvlc --play-and-exit ~/Downloads/nooo.mp3
    systemctl suspend"
alias reboot="systemctl reboot"
alias sleep="systemctl suspend"
alias clean="cd && clear"
alias poweroff="systemctl poweroff"

# Connect to render ssh instance.
alias ssh_connect="ssh srv-crq3n452ng1s73e22cag@ssh.oregon.render.com"
# # Work-around fix for tensorflow numa node error/warning.
# function numa_node_fix() {
#     for a in /sys/bus/pci/devices/*; do echo 0 | sudo tee -a $a/numa_node; done
# }

# Display global bin variable/alias help
# alias_plain_file_name is a plain text file without a file extension
function alias_help() {
    echo "chmod +x <alias_file_name>";
    echo "sudo cp <alias_file_name> /usr/local/bin/";
}

# View a given pdf file
function viewpdf() {
    nohup google-chrome $1&>/dev/null &
}

# View all pdf files in the current directory
function allpdf() {
     nohup google-chrome *.pdf&>/dev/null &
}

# Disables the middle button on the touchpad
function nope() {
    touchpad_id=$(xinput | grep Touchpad | grep -wo "id=[0-9][0-9]" | grep -Eo '[0-9]{1,4}');
    xinput set-button-map $touchpad_id 1 0 3 4 5 6 7;
}

# export PATH="/usr/local/cuda-11.4/bin:$PATH"
# export LD_LIBRARY_PATH="/usr/local/cuda-11.4/lib64:$LD_LIBRARY_PATH"
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# # Allows gpu memory expansion when using tensorflow keras
# export TF_GPU_ALLOCATOR="cuda_malloc_async"

# Symlink .bashrc 
#   - rm ~/.bashrc
#   - ln -s /home/bob/Bash/.bashrcexport PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/snap/bin:/home/bob/miniconda3/bin

# export PATH="$PATH:$HOME/miniconda3/bin"



# DEBAIN error: externally-managed-environment
#   $ sudo mv /usr/lib/python3.11/EXTERNALLY-MANAGED /usr/lib/python3.11/EXTERNALLY-MANAGED.old

# VIRTUAL ENVIRONMENT HELP
# Create virtual environment
#   $ python -m venv ./<virutal_env_name>[venv|env|.venv|etc]
# Activate virtual environment
#   $ source <virtual_env_name>/bin/activate
# Install requirements
#   $ python -m pip install -r requirements


# Bash Autocompletion
bind 'TAB: menu-complete'
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
source /usr/share/bash-completion/bash_completion
source <(karmadactl completion bash)
