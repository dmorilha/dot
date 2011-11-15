export PATH='/sbin:/usr/sbin:/usr/local/bin:/bin:/usr/bin';

umask 022;

export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

export LESS_BINARY=$(which less);
export VIM_BINARY=${VIM_BINARY:-$(which vim)};
export SSH_BINARY=${SSH_BINARY:-$(which ssh)};
export TPUT_BINARY=$(which tput);

export PAGER=${LESS_BINARY};

[ -r /etc/bashrc ] && source /etc/bashrc

if [[ $($TPUT_BINARY sgr0 2>/dev/null) && $? -eq 0 ]]; then

	black=$($TPUT_BINARY setaf 0);
	white=$($TPUT_BINARY setaf 7);
	background_blue=$($TPUT_BINARY setab 4);
	background_red=$($TPUT_BINARY setab 1);
	reset=$($TPUT_BINARY sgr0);

	ON_ERROR_CHANGE_COLOR="\$(if [ \$? -ne 0 ]; then echo -ne \[${background_red}\]; else echo -ne \[${background_blue}\]; fi; echo -ne \[${black}\])";

	export PS1="${ON_ERROR_CHANGE_COLOR}${USER/dmorilha/m}@${HOSTNAME} \t \W \[${reset}\]";

else
	export PS1="${USER/dmorilha/m}@${HOSTNAME} \t \W$ ";

fi;

[ -r "$HOME/.bashrc.yahoo" ] && source "$HOME/.bashrc.yahoo"
[ -r "${HOME}/.bashrc.local" ] && source "${HOME}/.bashrc.local"

export PATH="~/bin:${PATH}";

if [ $(uname) == 'Linux' ]; then
	ls='ls --color';
else
	ls='ls -G';
fi;

alias :q=exit
alias more="less"
alias rm="rm -i"
alias rmfr="rm -fR"
alias rmrf="rm -fR"
alias l1="ls -1"
alias ls="$ls -F"
alias ll="$ls -lh"
alias la="ll -a"

shopt -s checkwinsize
shopt -s histappend
shopt -s extglob
shopt -s extquote
shopt -s cdspell

if [ -n $VIM_BINARY ]; then
	alias \
		vi=$VIM_BINARY \
		vim=$VIM_BINARY \
		view="${VIM_BINARY} -R";

	export SVN_EDITOR=${SNV_EDITOR:-${VIM_BINARY}}
fi;

[ -n "$SSH_BINARY" ] && alias ssh=$SSH_BINARY && export SVN_SSH=$SSH_BINARY;
[ -n "$SCP_BINARY" ] && alias scp=$SCP_BINARY;
