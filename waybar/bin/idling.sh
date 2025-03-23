#!/bin/bash

status="$(loginctl show-session --property=IdleHint)"
if [[ "$status" == "IdleHint=yes" ]]; then
	icon=" 󰒲 "
else
	icon=" 󰒳 "
fi

echo -n "{\"text\": \"$icon\"}"
