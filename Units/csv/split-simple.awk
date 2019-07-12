
# ---------- Units/csv/split-simple.awk
# Will Split a csv file into NF fields
# Use this if you are sure the csv file does not contain /","/
# call check.awk before this to get multiline records

BEGIN {FS="\037";OFS=","}

{
 csvrecord = csvrecord $0
 $0=""
 NF = split(csvrecord,csvfields,/,/)
 csvrecord = ""
 for ( i=1;i<=NF;i++ ) $i = csvfields[i]
}
