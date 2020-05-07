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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

# Prompt colors
black="\[$(tput setaf 0)\]"
red="\[$(tput setaf 1)\]"
green="\[$(tput setaf 2)\]"
yellow="\[$(tput setaf 3)\]"
blue="\[$(tput setaf 4)\]"
magenta="\[$(tput setaf 5)\]"
cyan="\[$(tput setaf 6)\]"
white="\[$(tput setaf 7)\]"
reset="\[$(tput sgr0)\]"

# Generate a colorful git prompt
git_status() {
  git status 2> /dev/null
}

git_color() {
  if [[ "$(git_status)" =~ "Changes not staged for commit:" ]] ||
     [[ "$(git_status)" =~ "Untracked files:" ]]; then
    echo -e $(tput setaf 1)
  elif [[ "$(git_status)" =~ "Changes to be committed:" ]]; then
    echo -e $(tput setaf 2)
  elif [[ "$(git_status)" =~ "Your branch is ahead" ]]; then
    echo -e $(tput setaf 3)
  fi
}

# Add a symbol for new, deleted, or modified files
git_symbol() {
  gsym=""

  if [[ "$(git_status)" =~ "modified:" ]] ||
     [[ "$(git_status)" =~ "renamed:" ]]; then
    gsym+="~"
  fi

  if [[ "$(git_status)" =~ "Untracked files:" ]] ||
     [[ "$(git_status)" =~ "new file:" ]]; then
    gsym+="+"
  fi

  if [[ "$(git_status)" =~ "deleted:" ]]; then
    gsym+="-"
  fi

  echo $gsym
}

export PS1="${red}[\t] ${yellow}\u${blue}@${green}\h ${cyan}\w${reset}\$(git_color)\$(__git_ps1) \$(git_symbol)\n${green}. ${reset}"

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
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
