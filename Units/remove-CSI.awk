#!/usr/bin/awk -f

# Written by mknod in freenode

{ gsub("\x1b[[;<>=?:0-9]*[ \"\x27$&!#%()*+,-./]*[][a-zA-Z@\\^_`{|}~]", "") }
