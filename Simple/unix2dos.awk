#!/usr/bin/awk -f

# If you want to convert a file, use:
# unix2dos.awk file | sponge.awk | tee.awk file

BEGIN {
 RS="\n"
 ORS="\r\n"
}
1
