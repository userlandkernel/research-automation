#!/usr/bin/env bash
# Feed me a binary I give you the lockdown service name if any
jtool2 -d "$1" 2>/dev/null | grep -m 2 "lockdown_checkin_xpc" | head -n 3 | tail -n 1 | tr -d '\t' | awk -F '_lockdown_checkin_xpc' '{print $2}' | awk -F ","  '{print $1}' | tr -d "(\""
