
# ---------- Units/csv/check.awk
# Will check to see if its a multiline record

# Multi-Line String
(!csvrecord && /"/ && !/^([^"]|"[^"]*")*$/) || (csvrecord && /^([^"]|"[^"]*")*$/) {
 csvrecord = csvrecord $0 ORS; NR--; next
}


END {
 divider = "---------------------------"

 if (csvrecord) {
	printf("Unterminated record\t%i\n%sRecord:\n%s\n\n",NR,divider,csvrecord) > "/dev/stderr"
	exit 1
 }
}