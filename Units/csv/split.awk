
# ---------- Units/csv/split.awk
# Will Split a csv file into NF fields
# Call check.awk before this so you get multi-line records

BEGIN { FS="\037";OFS="," }

{
 csvrecord = csvrecord $0
 $0="" # I think this erases NF but it differs between awks

 # Can't split(/","/) so this if is a workaround
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
