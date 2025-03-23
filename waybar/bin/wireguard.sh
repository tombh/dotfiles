#!/bin/bash

interface=$(wg show interfaces)

if [ -n "$interface" ]; then
	interface=" $interface"
fi

echo -n "{\"text\": \"$interface\"}"
