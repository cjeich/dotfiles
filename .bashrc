#!/bin/sh

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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
force_color_prompt=yes

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
    PS1='\[\e[0;32m\]${debian_chroot:+($debian_chroot)}\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

#set xterm title
case "$TERM" in
  xterm | xterm-color)
    XTERM_TITLE='\[\e]0;\W@\u@\H\a\]'
  ;;
esac

## If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#    ;;
#*)
#    ;;
#esac

# Add git/svn branch to prompt
# Add git/svn branch to prompt
#     parse_git_branch() {
#       git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[git| \1]/'
#     }
        # Prompt Colors  
        c_cyan=`tput setaf 6`
        c_red=`tput setaf 1`
        c_green=`tput setaf 2`
        c_sgr0=`tput sgr0`
        

      parse_git_branch ()
      {
             if git rev-parse --git-dir >/dev/null 2>&1
             then
                    gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
                    if git diff --quiet 2>/dev/null >&2 
                    then 
                            gitver="${c_cyan}[${c_green}git${c_sgr0}|${c_green}$gitver${c_cyan}]${c_green}${c_sgr0}"
                    else 
                            gitver="${c_cyan}[${c_green}git${c_sgr0}|${c_red}$gitver☣${c_cyan}]${c_green}${c_sgr0}"
                    fi
                 else    
                    return 0
                 fi
                    echo $gitver
     }

     parse_svn_branch() {
       parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print "«"$1 "/" $2 "»"}'
     }
     parse_svn_url() {
       svn info 2>/dev/null | grep -e '^URL*' | sed -e 's#^URL: *\(.*\)#\1#g '
    }
    parse_svn_repository_root() {
      svn info 2>/dev/null | grep -e '^Repository Root:*' | sed -e 's#^Repository Root: *\(.*\)#\1\/#g '
    }
   export PS1="\[\033[0;0m\]\u@\h\[\033[01;34m\]:\w \[\033[1;30m\]\$(parse_git_branch)\$(parse_svn_branch)\[\033[0;1m\]$\[\033[0;0m\] "


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
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

#source the right system level file for auto-complete
source /etc/bash_completion

#### PATH #####
export PATH=~/editors/Komodo-Edit-6/bin:$PATH
export PATH=$PATH:~/bin
export PATH=$PATH:$JAVA_HOME/bin

# SVN URLs ... b/c typing out the whole thing is tedious
export sfl_path="svn://jason.trinnovations.com/seniorsforliving.com"
export ces_path="svn://cessvn.trinnovations.com/admin_ces"
export csurfing_path="svn://cessvn.trinnovations.com/collegesurfing.com"
export cba_path="svn://cessvn.trinnovations.com/collegeboundadvisor.com"
export ftrj_path="svn://cessvn.trinnovations.com/fintherightjob"
export cc_path="svn://cessvn.trinnovations.com/callcenter.collegebound.net"
export me_path="svn://cessvn.trinnovations.com/myeducation.com"

########### My Aliases ###########
alias admin_ces="cd /data/httpd/html/contests/admin_ces"
alias c.org="cd /home/dragonwww/domains/careers.org/public_html/current/public"
alias snv="svn"
alias ces="cd /data/httpd/html/contests/admin_ces"
alias sodu="sudo"
alias clr="clear; echo -e \"\n\n\""
alias aptana="/home/chris/editors/Aptana\ Studio\ 3/studio3.sh"
alias bash_edit="sudo nano ~/.bashrc"
alias edit_bash="sudo nano ~/.bashrc"
alias snvtool='svntool'
alias agi='sudo apt-get install'
alias acs='sudo apt-cache search'
alias server_name='ssh -v -l USERNAME IP ADDRESS'
alias la='ls -a'
alias df='df -h'
alias aka='cat ~/.bashrc | grep alias'
alias ipconfig='ifconfig'


#Function to make directory and move into it
function md () { mkdir -p "$@" && cd "$@"; }
function task(){
	for taskID in $@
	do 
		google-chrome "http://www.trinnovations.com/trinntask/task.php?action=edit&id=${taskID}" 2>1 1>/dev/null&
	done
}

#function for moving to different directories of SFL
function sfl(){  
	if [[ -e /var/www/vhosts/seniorsforliving.com/httpdocs_${1} ]]
	then  #Go to directory if appending port to direcory_ exists
		cd /var/www/vhosts/seniorsforliving.com/httpdocs_${1}; 
	else  # Otherwise go to default sfl directory
		cd /var/www/vhosts/seniorsforliving.com/httpdocs; 
	fi 
	}

# Fix misstyped cd commands
alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Command Completion for Bash
complete -W "`pear 2>&1 | awk '{ORS=" "} /[a-zA-Z-]+  / {print $1}'`" -f pear

# Git Aliases
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '
alias gk='gitk --all&'
alias gx='gitx --all'

alias got='git '
alias get='git '

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
