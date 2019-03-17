
# Will convert all tokens into a field
# RS is ignored
# if strings have a newline... RS=""

BEGIN {FS="\036";OFS="|"}

{
 string=$0;$0=""
# printf NR"\t"

 while (length(string)>0) {
  match(string,/^[ \t\n]*/)
   string=substr(string,RSTART+RLENGTH) # Ignore and jump whitespace

  if ( ! match( string, rall ) ) {
    print "Error: Malformed JSON" > "/dev/stderr"
    exit 1
  }

  # save in a field
  $(++NF)=substr(string,RSTART,RLENGTH)
  string=substr(string,RSTART+RLENGTH)
 }

 print
 c+=NF
}

END {print c}
# Sets regex so you can concatenate and create your regex
# values are inexact, concatenate ^ and $ to the r

BEGIN {
 # Notes
  # no exact matching
 ronechar	= "[{}:,\\[\\]]"
 rboolean	= "^null|^true|^false"
 rdec		= "[+-]?[0-9]*\\.?[0-9]+"	# Signed Decimal
 rstr		= "\"[^\"]*\""		# lonely string
 rstring	= "\"([^\"\\\\]*(\\\\\\\")[^\"\\\\]*)+\"" # String with escapes
 rall = rboolean "|^" ronechar "|^" rdec "|^" rstr "|^" rstring
# print rall
# exit
}
