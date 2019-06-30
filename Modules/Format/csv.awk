
# ---------- csv.awk

# Will convert all tokens into a field

BEGIN {
 FS="\037"
}

# Multi-Line String
(!csvrecord && /"/ && !/^([^"]|"[^"]*")*$/) || (csvrecord && /^([^"]|"[^"]*")*$/) {
 csvrecord = csvrecord $0 ORS; NR--; next
}

{
 csvrecord = csvrecord $0
 $0="" # I think this erases NF but it differs between awks

 # Can't split(/","/) so this if is a workaround
 if ( csvrecord ~ /^([^",]*,?("[^"]*,[^"]*"),?[^,]*)+$/ ) { # Basically /","/, but will fail with """
 # Which is mitigated with the Multi-line regex above, (so its good enough?)
  while(match(csvrecord,/^[^,"]*,|^"[^"]*("")*[^"]*",/)){
	$(++NF)		= substr(csvrecord,RSTART,RLENGTH-1)
	csvrecord	= substr(csvrecord,RSTART+RLENGTH)
  }
  $(++NF) = csvrecord
  } else {
	NF = split(csvrecord,csvfields,/,/) # This works if theres no ","
	for ( i=1;i<=NF;i++ ) $i = csvfields[i]
 }
 csvrecord = ""
}

END {
 divider = "---------------------------"

 if (csvrecord) {
	printf("Unterminated record\t%i\n%sRecord:\n%s\n\n",NR,divider,csvrecord) > "/dev/stderr"
	exit 1
 }
}

# TODO:
 # csv_equivalency_check, NF must be the same for all records
 # maybe gsub(/[\n]/,"\\n",csvrecord?)
