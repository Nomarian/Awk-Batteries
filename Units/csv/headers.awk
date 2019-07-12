
# --------- Units/csv/headers.awk

# Depends: verify-nf-headers
# After: headers-split-after

# This will create csvheader[]
# This allows you to call from your program, csvheader["name"]
# thus not worrying about where the field number is in your code
# Be aware that a split(/,/) is used for parsing the fields, so you cannot have commas in your headers


# slightly confused whether "1" should be a header, 1 should not be, but is "1" allowed?
# "1" is allowed

BEGIN {
# ignore empty lines at the beginning?
# while (!csvrecord) getline csvrecord
 getline csvrecord; NR=0
 lnf = split(csvrecord,csvheader,",")
 csvrecord=""

 if (!lnf) {
  print "Error: No headers found" > "/dev/stderr"
  exit 1
 }

 for (i=1;i<=lnf;i++) {
  if (csvheader[i] ~ /^".+"$/)
   csvheader[i] = substr(csvheader[i],2,length(csvheader[i])-1)

  if (!csvheader[i]) {
   print "Error: Header is empty" > "/dev/stderr"
   exit 1
  }

  if (csvheader[i] ~ /^[0-9]+$/) {
   print "Error: Header is a number" > "/dev/stderr"
   exit 1
  }

  if (csvheader[i] ~ /"/) { # or remove the quote?
   print "Error: Header contains a quote" > "/dev/stderr"
   exit 1
  }

 }
}
