
# Searches fields for regex, returns index if field is found or 0
function getfield(regex){
 for (i=1;i<=NF;i++)
  if ($i ~ regex ) return i
 return 0
}
