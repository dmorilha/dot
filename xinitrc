xrdb -merge ~/.xresourcesrc
bash -c 'python2 ${HOME}/dsouza/dzen-tools/bin/systat2dzen | tee >(${HOME}/dsouza/dzen-tools/bin/run_dzen2_top -xs 1) | ${HOME}/dsouza/dzen-tools/bin/run_dzen2_top -xs 2' &
xrandr --output VGA1 --right-of DVI1
xset -b
xsetroot -cursor_name left_ptr
setxkbmap -layout "us,us_intl" -option "grp:alt_space_toggle"
exec ssh-agent xmonad
