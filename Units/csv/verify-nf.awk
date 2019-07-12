
# ---------- Units/csv/verify-nf.awk

# Will check to see if the number of fields is even, as RFC dictates
# headers-checknf.awk also does this, but it uses getline to check only the first line
# Which saves you a conditional check for each record

!lnf { lnf = NF }
NF != lnf {
 print "Uneven number of fields" > "/dev/stderr"
 exit 1
}
