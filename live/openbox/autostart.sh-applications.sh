#!/usr/bin/env  sh

# The global settings are: /etc/xdg/openbox/autostart.sh
# The local master settings are: /home/user/.config/openbox/autostart.sh
# Then this file is run..


disconnected() {
  \echo  " * Internet connection not detected."
  # I don't do anything special in this case.

  # TODO: wmctrl and minimize it.  Heck, toss it on another desktop.
  /l/shell-random/git/live/projects.sh &
  # This is so bad, but it'll be a decent workaround.
  \geany  /mnt/1/windows-data/l/live/__/__.txt &
  \geany  /mnt/1/windows-data/l/live/_outbox--1/_outbox--1.txt &
}


connected() {
  \echo  " * Internet connection detected."

  #
  # IRC
  #

  # X-Chat
  #   It's already configured to auto-connect to servers and join channels.
  #   --minimize=2  =  Minimize to the tray
  #\xchat --minimize=2 &

  # WeeChat
#  /l/shell-random/git/live/terminal.sh  FORCE \
#    \urxvtc \
#      -geometry 239x64 \
#      +sb                   ` # Remove the scroll bar ` \
#      -e \weechat

  #
  # Instant Messaging
  #
  #\empathy &

  #
  # VoIP
  #
  #\twinkle&

  # Password
  \keepassx  /mnt/1/windows-data/l/live/keepassx-passwords--linux-and-windows.kdb  -min  -lock &
  \keepassx  /l/e/keepassx-passwords--linux-only.kdb                               -min  -lock &

  /l/e/Pale\ Moon/go.sh default &

  # Voice Chat
  # TODO:  How do I get Mumble to minimize on startup?
#  /l/bin/mumble.sh

  # Email
  #   Can be started trayed (it gets minimized to the tray after a moment)
  #     but only if I set the tray plugin to do that.
  \claws-mail &

  # RSS reader
  # Slated to be replaced by.. anything.  Fucking thing can't even open its gui when run once.  Has to be run twice.
  #\liferea &

  # TODO: wmctrl and minimize it.  Heck, toss it on another desktop.
  /l/shell-random/git/live/projects.sh &
  # This is so bad, but it'll be a decent workaround.
  \geany  /mnt/1/windows-data/l/live/__/__.txt &
  \geany  /mnt/1/windows-data/l/live/_outbox--1/_outbox--1.txt &

  \spacefm \
    --panel=1 \
    --new-window \
    --no-saved-tabs \
    --reuse-tab \
    /l/ &

}


:<<OLD_METHOD
# --
# -- Internet connection test
# --
# example.com is supposed to be provided by the ISP.
\ping  -n  -q  -w 2  example.com  &> /dev/null
# TODO - there ought to be a better way to do this..
# ping not found || ping doesn't find a connection
if [ $? -eq 127 || $? -eq 2 ]; then
  # internet=false
  disconnected
else
  # internet=true
  \zenity  --question
  if [ $? -eq 0 ]; then
    connected
  else
    # zenity not found || user said no
    exit 1
  fi
fi
OLD_METHOD


# --
# -- Network connection test
# --

for interface in $( \ls /sys/class/net/  |  \grep  --invert-match  lo ); do
  if [ $( \cat /sys/class/net/$interface/carrier ) = 1 ]; then
    \zenity  --question
    if [ $? -eq 0 ]; then
      connected
    else
      # zenity not found || user said no
      exit 1
    fi
  else
    disconnected
  fi
done



# --
# -- No net connection required for stuff down here.
# --


# An initial terminal
# \xterm  -fn 9x15  -bg black  -fg gray  -sl 10000  -geometry 80x24+0+0 &
# \Terminal  --geometry 80x24+10+10 &
# /l/shell-random/git/live/terminal.sh
