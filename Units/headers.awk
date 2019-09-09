
# header setup
# There is no getline call
# headers expects you to have already issued a getline call
# This is done in case you want to have a specific NF or FS

BEGIN{
# getline
 for (i=1;i<=NF;i++) {
  h[i]=$i
  h[$i]=i
 }
}
