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

	fg_norm_yellow='[22;33m'
	bg_norm_yellow='[22;43m'
	fg_bold_yellow='[01;33m'
	bg_bold_yellow='[01;43m'

	fg_norm_blue='[22;34m'
	bg_norm_blue='[22;44m'
	fg_bold_blue='[01;34m'
	bg_bold_blue='[01;44m'

	fg_norm_cyan='[22;36m'
	bg_norm_cyan='[22;46m'
	fg_bold_cyan='[01;36m'
	bg_bold_cyan='[01;46m'

	fg_norm_white='[22;37m'
	bg_norm_white='[22;47m'
	fg_bold_white='[01;37m'
	bg_bold_white='[01;47m'

	fg_norm_def='[22;39m'
	bg_norm_def='[22;49m'
	fg_bold_def='[01;39m'
	bg_bold_def='[01;49m'

	nocolors='[0m'
}

font-size() {
	font='xft:Monaco';
	printf '\33]50;%s%d\007' "${font}:size=" $1;
}

my_colors;

export PROMPT_COMMAND="[ \$? -gt 0 ] && export PROMPT_COLOR='${fg_norm_red}${bg_norm_black}' || export PROMPT_COLOR='${fg_norm_cyan}${bg_norm_black}'";
export PS1="\[\${PROMPT_COLOR}\]${USER/dmorilha/m}@${HOSTNAME} \t \W \[${nocolors}\]";
#export MAKEPKG="makepkg --skipinteg"
export DISPLAY=:0
export VISUAL=vim

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

alias scanimage1='scanimage --source="Automatic Document Feeder" --format=tiff --mode=gray --resolution=300 --batch'
alias scanimage2='scanimage --source="Automatic Document Feeder" --format=tiff --mode=gray --resolution=300 --batch --batch-double'
alias scanimage3='scanimage --source="Automatic Document Feeder" --format=tiff --mode=gray --resolution=300 --batch --batch-double --batch-start=2'
alias topdf='MAGICK_TMPDIR=/data convert -limit memory 32 -limit map 32 -density 200 -colorspace Gray -quality 60 -compress jpeg `echo \` ls out?.* ; ls out??.* \``  out.pdf'
alias xvidenc='xvidenc -2p -p uhq'

[ -r ~/.bashrc.local ] && source ~/.bashrc.local;
