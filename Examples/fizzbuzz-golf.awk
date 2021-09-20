#!/usr/bin/awk -f

# Run me as seq N | fizzbuzz.awk

$0=(x=($0%3?z:"fizz")($0%5?z:"buzz"))?x:$0
