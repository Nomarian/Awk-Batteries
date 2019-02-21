#!/usr/bin/awk -f

BEGIN {
  sub(/\/[^/]+$/,"",ARGV[1])
  print ARGV[1]
  exit 0
}
