#!/bin/sh

# Run files in the xinitrc.d directory
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Merge current Xresources with those found in $HOME
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Start up xfce session
exec startxfce4

# Budgie from Solus
# export XDG_CURRENT_DESKTOP=Budgie:GNOME
# exec budgie-desktop