
# Will convert all tokens into a field
# RS is ignored
# if strings have a newline... RS=""

BEGIN {FS="\036";OFS=""}

{
 string=$0;$0=""
# printf NR"\t"

 while ( match(string,/[{}:,"\[\]0-9tfn\-\+]/) ) { # match everything
  string=substr(string,RSTART) # Advance input

  match( string, # Match a value or a string (last 2)
   /^null|^true|^false|^[+-]?[0-9]*\.?[0-9]+|^[{}:,\[\]]|^"[^"]*"|^"([^"\\]*(\\\")[^"\\]*)+"/ ) # oh no!

  # save in a field
  $(++NF)=substr(string,RSTART,RLENGTH)
  string=substr(string,RSTART+RLENGTH)
 }

# print
}
#END {print "END"}
