
# --------- Units/csv/headers.awk

# Depends: verify-nf-headers.awk

{ 
 for(i=1;i<=lnf;i++)
  csvheader[ csvheader[i] ] = $i
}