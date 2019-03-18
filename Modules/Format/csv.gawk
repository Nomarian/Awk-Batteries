
# ---------- csv.gawk

#( Notes )#
# fields cannot have \r or \n, strings can
# If the last record ends in \r\n it will mark it as RS
#  so you might want to NF>0

BEGIN {
 FS="\036"
 OFS="||"

 rend	= "\\r\\n" # actual RS

 q		= "\""
 rstr		= "[^\"]*" # ignores RS
 rq		= "(" q q ")*" # ""
 rstring	= q rq rstr rq q
 
 rfield = "[^,\"" rend "]+" # Will match a field without \r|\n

 RS= "(,|" rfield "|" rstring ")+" 
 
 ORS="\n"
}

{
 string=RT;$0=""

 while (length(string)>0) {
  match(string,/^,/)
   string=substr(string,RSTART+RLENGTH) # Ignore and jump

  if ( ! match( string,/^[^,]+|^"[^"]*"|^"[^"]*("")*[^"]*"/ ) ) {
   RSTART=2;RLENGTH=0
  }

  # save in a field
  $(++NF)=substr(string,RSTART,RLENGTH)
  string=substr(string,RSTART+RLENGTH)
 }
}

