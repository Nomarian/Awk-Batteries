#!/usr/bin/awk -f

{
 words += NF
 chars += length($0 ORS)
}

END {
 printf(" %i\t%i\t%i\t%s\n", NR, words, chars, FILENAME)
}
