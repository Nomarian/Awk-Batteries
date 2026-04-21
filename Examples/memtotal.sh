#!/bin/sh

awk '
 $2>1024 {$2=$2/1024 ;$NF="mB"}
 $2>1024 {$2=$2/1024; $NF="gB" }
 1
' /proc/meminfo | column -t
