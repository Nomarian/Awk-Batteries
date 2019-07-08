#!/usr/bin/awk -f

# If you want to convert the file, use 
# dos2unix.awk file | sponge.awk | tee.awk file

BEGIN {
 RS="\r\n"
 ORS="\n"
}
1
