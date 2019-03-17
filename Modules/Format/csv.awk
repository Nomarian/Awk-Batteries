
# ---------- csv.awk

# Will convert all tokens into a field
# newlines in strings is unsopported

BEGIN {FS="\036"}

{
 string=$0;$0=""

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
