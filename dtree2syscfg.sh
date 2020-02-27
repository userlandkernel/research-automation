#!/usr/bin/env bash

if [ -z "$1" ]; then
	echo "Usage: $0 [devicetree.txt]"
	exit 1;
fi

DTREE=$(cat "$1")
SYSCFG=$(echo "$DTREE" | grep "syscfg")
SYSCFG=$(echo "$SYSCFG" | tr -d '|+' | sed -e 's/--//g' -e 's/  //g' -e 's/syscfg//g')
SYSCFG=$(echo "$SYSCFG" | sed -e 's/\// /g' -e 's/zeroes//g' -e 's/0x.*//g' -e 's/bytes//g' -e 's/ macaddr //g')
SYSCFG=$(echo "$SYSCFG" | awk '{print $1" "$4}')
echo "$SYSCFG"
