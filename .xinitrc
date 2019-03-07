# When setting up a new system: `localectl set-x11-keymap gb`

# A better DPI for my XPS 13 QHD+ scren
xrandr --dpi 220

# Touchpad setup
# Lightly tapping the touchpad is the same as a left click
synclient TapButton1=1
synclient TapButton2=3
synclient TapButton3=2
synclient HorizTwoFingerScroll=1

# Automatically lock the screen after some time
xautolock -time 15 -locker 'i3lock -c000000' &
# Automatically lock the screen after suspend
xss-lock -- i3lock -c000000 &

# Turn off my touchscreen, I hardly ever use it
# There also seems to be some battery saving from setting the touchscreen
# to automaticaly turn off in powertop.
xinput set-prop "ELAN Touchscreen" "Device Enabled" 0

# Start Redshift to make the screen redder at night
# Set manual lat/lon in ~/.config/redshift.conf or use geoclue, which in /etc/geoclue/geoclue.conf needs:
#   [redshift]
#   allowed=true
#   system=false
#   users=
pgrep redshift &> /dev/null || redshift &> /dev/null &

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx

# Start i3 window manager
exec i3 -V -d all >/tmp/i3.log 2>&1
