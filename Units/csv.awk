
# ---------- Units/csv.awk

# Will convert all tokens into a field

BEGIN {
 FS="\037"
}

# Multi-Line String
 # csvrecord is empty AND stringisodd ||
  # OR csvrecord is not empty and string is anything or StringIsEven
(!csvrecord && /^("[^"]*"|[^"])*"[^"]*$/) || (csvrecord && /^([^"]|"[^"]*")*$/) {
 csvrecord = csvrecord $0 ORS; NR--; next
}

{
 csvrecord = csvrecord $0
 $0="" # I think this erases NF but it differs between awks

 # Can't split(/","/) so this if is a workaround
  # also this regex looks long and complicated, its just /^z*$|^z*,z$/
  # z is match [not a comma or quotes]| quotation
 if ( csvrecord ~ /^([^",]*|"([^",]|"")*")*$|^(([^",]*|"([^",]|"")*")*,([^",]*|"([^",]|"")*")*)+$/ ) {
	NF = split(csvrecord,csvfields,/,/) # This works if theres no ","
	for ( i=1;i<=NF;i++ ) $i = csvfields[i]
  } else {
   while( match(csvrecord,/^([^",]|"([^"]|"")*")*,/) ){
	$(++NF)		= substr(csvrecord,RSTART,RLENGTH-1)
	csvrecord	= substr(csvrecord,RSTART+RLENGTH)
   }
	$(++NF) = csvrecord
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
