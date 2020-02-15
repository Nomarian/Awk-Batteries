
# This should remove whitespace

{
 for (i=1;i<=NF;i++) {
  match($i,/"[^"]*"|[^ \t]+/) # better with the "" bit
  $i = substr($i,RSTART,RLENGTH)}
 }
}
