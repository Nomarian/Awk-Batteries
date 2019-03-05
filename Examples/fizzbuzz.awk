#!/usr/bin/awk -f

 (($1%3 || $2="fizz") ($1%5 || $3="buzz")) {}
 $2 || $3 {print $2 $3;next}
 {print $1}
