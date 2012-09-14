umask 022;

export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

my_colors () {
	fg_norm_black='[22;30m'
	bg_norm_black='[22;40m'
	fg_bold_black='[01;30m'
	bg_bold_black='[01;40m'

	fg_norm_grey=$fg_norm_black
	bg_norm_black=$bg_norm_black
	fg_bold_grey=$fg_bold_black
	bg_bold_black=$bg_bold_black

	fg_norm_red='[22;31m'
	bg_norm_red='[22;41m'
	fg_bold_red='[01;31m'
	bg_bold_red='[01;41m'

	fg_norm_magenta='[22;35m'
	bg_norm_magenta='[22;45m'
	fg_bold_magenta='[01;35m'
	bg_bold_magenta='[01;45m'

	fg_norm_green='[22;32m'
	bg_norm_green='[22;42m'
	fg_bold_green='[01;32m'
	bg_bold_green='[01;42m'

}

font-size() {
	font='xft:Monaco';
	printf '\33]50;%s%d\007' "${font}:size=" $1;
}

my_colors;

export PROMPT_COMMAND="[ \$? -gt 0 ] && export PROMPT_COLOR='${fg_norm_red}${bg_norm_black}' || export PROMPT_COLOR='${fg_norm_cyan}${bg_norm_black}'";
export PS1="\[\${PROMPT_COLOR}\]${USER/dmorilha/m}@${HOSTNAME} \t \W \[${nocolors}\]";

ls=${ls:-$(which ls;)};
[ "$(uname)" == 'Linux' ] && ls="${ls} --color" || ls="${ls} -G";

alias rm="rm -i"

alias l1="$(which ls) -1";
alias ls="$ls -F";
alias ll="$ls -lh";
alias la="$ls -lah";

shopt -s checkwinsize;
shopt -s histappend;
shopt -s extglob;
shopt -s extquote;
shopt -s cdspell;

[ -r ~/.bashrc.local ] && source ~/.bashrc.local;
