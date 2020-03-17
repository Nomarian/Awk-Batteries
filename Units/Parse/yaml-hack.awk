
$1 ~ /^#/ {next}
NF==0 {tree=""}
$1 ~ /:$/ {tree=tree $1}

# how to use, use tree ~ //
# tree ~ /^auditlog:/ && tree ~ /(repository|tag):$/ {print $2}