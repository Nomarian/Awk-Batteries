
# ---------- csv.awk

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
# printf("%s:\t%s%s",NR,RT,ORS)

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
# exit
}
NF>0 { printf("%s:\t%s%s",NR,$0,ORS) }

#END {print NR}
