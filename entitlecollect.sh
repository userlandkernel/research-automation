#!/usr/bin/env bash

### Written by @userlandkernel ###
### This script gets all the entitlements for all binaries on the filesystem ###

mkdir -p entitlements
mkdir -p entitlements/tfp/

function GetAllExecutables() {
  find / -type f -executable
}

function GetEntitlements() {
  for exe in $(GetAllExecutables);do
    ent=$(jtool2 --ent)
    echo "$ent" | grep "task_for_pid-allow" > /dev/null
    if [ $? -eq 0 ]; then
      echo "$exe has task_for_pid-allow entitlement!"
      echo "$ent" > "entitlements/tfp/$(basename $exe).plist"
    else
      echo "$ent" > "entitlements/$(basename $exe).plist"
    fi
  ;done
}


