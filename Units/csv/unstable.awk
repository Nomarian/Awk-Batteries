
# Examples
# awk -f csv.awk -e 'NR==4' file # Will print the 4th record
# awk -f csv.awk 'NR==4 {$(NF+1) = qs("Testing 1 2 3") OR q "test" q}' file

# ---------- csv.awk

# Will convert all tokens into a field

# This will recognized newlines in strings and set $fields accordingly, as well as NR.
# There are some set global keywords which you should not overwrite, look at #( Globals )# for the list

#( Globals )#
 # Functions:
	# sas()		Set As Quotes as in ["",""] 
	# qs(string)	returns a Quoted String -- ""
 # Arrays:
	# csvfields (Contains the fields)
 # Variables:
	# csvrecord
	# q = "
	

BEGIN {
 FS="\037"
 divider="-----------------------------------"
 # q = "\""
 # OFS= "," ?
}

# Due to limitations in awk, there is no way to match a csv record with newlines using a regex
# gawk has RS=csvrecordregex and then you can $0=RT but there are... boundary errors?

# Multi-Line String
(!csvrecord && /"/ && !/^([^"]|"[^"]*")*$/) || (csvrecord && /^([^"]|"[^"]*")*$/) {
 csvrecord = csvrecord $0 ORS; NR--; next
}

{
 csvrecord = csvrecord $0
 _CSVRECORD_DEBUGGER_ = csvrecord
 $0="" # I think this erases NF but it differs between awks
 if ( csvrecord ~ /^("[^",]*"|[^"]*)*("[^"]*,[^"]*")("[^",]*"|[^"]*)*$/ ) { # Basically /","/
 # Which is mitigated with the Multi-line regex above
 # can you gsub("\a") then split "\a" ?
 # Can't use a simple split() here, need to do it by hand/chunks
	splitterq = "SHIT SPLIT!"
  while(match(csvrecord,/^[^,"]*,|^"([^"]|"")*",/)){
	$(++NF)		= substr(csvrecord,RSTART,RLENGTH-1)
	csvrecord	= substr(csvrecord,RSTART+RLENGTH)
  }
  $(++NF) = csvrecord
#  if (csvrecord) $(++NF) = csvrecord # only necessary if you are using this as a function
  } else { # split cant , and regex is hard
  	splitterq =  "SPLITTING WITH SPLIT"
	NF = split(csvrecord,csvfields,/,/) # This works if theres no ","
	for ( i=1;i<=NF;i++ ) $i = csvfields[i]
	# delete csvfields ? MAYBE
 }
 csvrecord = ""
}


# Headers
!lastnf { lastnf = NF }

lastnf != NF {
 printf("NF:%i\t%s\nRecord:\n%s\n%s\n\n",NF,splitterq,_CSVRECORD_DEBUGGER_,divider)
 exit 1
}

END {
 if (csvrecord) {
	printf("Unterminated record\t%i\n%sRecord:\n%s\n\n",NR,divider,csvrecord) > "/dev/stderr"
	exit 1
 }
}

# Regex Graveyard:
# /^("[^",]*"|[^"]*)*("[^"]*,[^"]*")("[^",]*"|[^"]*)*$/ -- By TimVDE, will match ",", doesn't support ""
# /^[^",]*,?("[^"]*,[^"]*")+,?[^,]*$/ # Supports "" but not """, not necessary since we already have a full record

# TODO:
 # csv_equivalency_check, NF must be the same for all records
# maybe gsub(/[\n]/,"\\n",csvrecord)
# Fields should not have a "", maybe for (NF) if (/^"[^"]"$/) substr( 2,length-1) ?
# this is better as a function, because its gonna get used a lot
# paq is a function that prints as quotes, and maybe gsub "" with "?
# export function that prints $0 as a proper csvrecord
# Maybe dealing with multiple files?
# sas set as quote "" (to a variable?, to a string?, to the fields?)
# qs
# The gawk version should be this, and just FPAT... maybe?
# with gawk you can probably just use match() with an array
