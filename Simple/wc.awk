#!/usr/bin/awk -f

{
 words += NF
 chars += length($0 RS)
}

END {
 printf(" %i\t%i\t%i\t%s\n", NR, words, chars, FILENAME)
}
