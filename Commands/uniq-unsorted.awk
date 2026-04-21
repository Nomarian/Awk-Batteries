#!/usr/bin/awk -f

# Uniq but not sorted
# Could calculate a hash instead of saving the string, if big strings

!($0 in a) {print;a[$0]++}
