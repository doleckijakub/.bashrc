# ~/.bashrc

[[ $- != *i* ]] && return

shopt -s globstar

Cr="\033[0;0m" # reset
C0="\033[0;37m" # white
C1="\033[0;36m" # cyan
C2="\033[0;34m" # blue
Cgit="\033[0;33m" # yellow

shell_stack()
{
	TREE="`pstree -TAsp $$ | grep -oE '.+'$$`)"
	echo $TREE | sed 's/([0-9]*)//gi' | sed 's/---/→/gi'
}

git_branch()
{
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

exit_status()
{
	RET=$?
	[ ! $RET -ne 0 ] && echo "$RET"
}

time_taken()
{
	c=$(date +%s)
	if [[ -f /tmp/$$lt ]]; then
		t=$(($c - $(cat /tmp/$$lt)))

		d=$((t/60/60/24))
		h=$((t/60/60%24))
		m=$((t/60%60))
		s=$((t%60))

		if [[ $d > 0 ]];
			then echo -n "${d}d "
		fi
		if [[ $h > 0 ]];
			then echo -n "${h}h "
		fi
		if [[ $m > 0 ]];
			then echo -n "${m}m "
		fi
		if [[ $s > 0 ]];
			then echo -n "${s}s"
		fi
	fi
	echo $c > /tmp/$$lt
}

PS1="\n$C1\n┌─<\$(shell_stack)>\n├─($C2\u@\h$C1)-[$C0\w$C1] $Cgit\$(git_branch)$Cr \$(time_taken)$C1\n└──$C2\$$Cr "

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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
export TERM=linux

date
uptime -p
