#!/bin/sh

ln_bin=/bin/ln
env_bin=/usr/bin/env
git_bin=${GIT_BIN:-$(which git)}

print_info()
{
	printf "%s\n" "$1"
}

print_error()
{
	printf "ERROR - %s\n" "$1"
	exit 1
}

check_binaries()
{
	if [ ! -x "$git_bin" ]; then
		print_error "git binary not found"
	fi

	if [ ! -x "$ln_bin" ]; then
		print_error "ln binary not found"
	fi

	if [ ! -x "$env_bin" ]; then
		print_error "env binary not found"
	fi
}

dot_clone_dot()
{
	print_info "CLONING DOT INTO $HOME/.dot"

	if [ -d "$HOME/.dot" ]; then
		(cd "$HOME/.dot" && $git_bin reset --hard)
		(cd "$HOME/.dot" && $git_bin pull)
	else
		$git_bin clone git://github.com/dmorilha/dot.git "$HOME/dot"
	fi
}


dot_install_dot()
{
	print_info "INSTALLING DOT FILES"

	$ln_bin -s -f -n "$HOME/dot/bash_profile" "$HOME/.bash_profile"
	$ln_bin -s -f -n "$HOME/dot/bash_profile.yahoo" "$HOME/.bash_profile.yahoo"
	$ln_bin -s -f -n "$HOME/dot/bashrc" "$HOME/.bashrc"
	$ln_bin -s -f -n "$HOME/dot/bashrc.yahoo" "$HOME/.bashrc.yahoo"
	$ln_bin -s -f -n "$HOME/dot/gitconfig" "$HOME/.gitconfig"
	$ln_bin -s -f -n "$HOME/dot/inputrc" "$HOME/.inputrc"
	$ln_bin -s -f -n "$HOME/dot/screenrc" "$HOME/.screenrc"
	$ln_bin -s -f -n "$HOME/dot/vim" "$HOME/.vim"
	$ln_bin -s -f -n "$HOME/dot/vimrc" "$HOME/.vimrc"

	touch "$HOME/.vimrc.local";
}

check_binaries
dot_clone_dot
dot_install_dot
