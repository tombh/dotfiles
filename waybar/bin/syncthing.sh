#!/bin/bash

status="$(systemctl is-active syncthing@tombh)"
if [[ "$status" == "active" ]]; then
	icon="󰅠 "
else
	icon=" "
fi

echo -n "{\"text\": \"$icon\"}"
