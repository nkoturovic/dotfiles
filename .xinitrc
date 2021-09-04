DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"


if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

session=${1:-gnome}

case $session in
        i3              ) exec i3;;
        gnome           ) exec gnome-session;;
        *) exec $1;;
esac