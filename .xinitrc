# Automatically lock the screen after some time
# Remember to use a systemd script to automatically lock after
# coming back from suspend.
exec --no-startup-id xautolock -time 15 -locker i3lock

# Turn off my touchscreen, I hardly ever use it
# There also seems to be some battery saving from setting the touchscreen
# to automaticaly turn off in powertop.
xinput set-prop "ELAN Touchscreen" "Device Enabled" 0

# Start Redshift to make the screen redder at night
pgrep redshift &> /dev/null || redshift &> /dev/null &

# Start i3 window manager
exec i3 -V -d all >/tmp/i3.log 2>&1
