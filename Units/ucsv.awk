
# Setting CSVEVENFIELDS to anything will warn if fields are uneven
# Setting CSVEVENFIELDS to 2 will exit

# ---------- Units/csv.awk

# Will convert all tokens into a field

BEGIN {
 FS="\037"
 OFS=","
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

!lnf { lnf = NF }
NF != lnf {
 if (ENVIRON["CSVEVENFIELDS"]>0)
  printf("Record %i has an uneven number of fields\n",NR) > "/dev/stderr"

 if (ENVIRON["CSVEVENFIELDS"]==2) exit 1
}

END {
 divider = "---------------------------"

 if (csvrecord) {
	printf("Unterminated record\t%i\n%sRecord:\n%s\n\n",NR,divider,csvrecord) > "/dev/stderr"
	exit 1
 }
}

# TODO:
 # maybe gsub(/[\n]/,"\\n",csvrecord?)
 # Headers?
