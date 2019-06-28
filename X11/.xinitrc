#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

# Only run xmodmap when I need to
if [ -f $sysmodmap && AUTO_XMODMAP -eq 1 ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -f "$HOME/.envs" ]; then
  source "$HOME/.envs"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# fcitx configuration
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
fcitx &

#export GDK_SCALE=2
#export GDK_DPI_SCALE=2

xbindkeys

eval $(ssh-agent)

# increase keyboard auto repeat rate
# See https://unix.stackexchange.com/questions/58651/adjusting-keyboard-sensitivity-in-a-command-line-terminal
#xset r rate 200 70

#exec awesome
exec i3
