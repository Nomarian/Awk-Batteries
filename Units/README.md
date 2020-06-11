
# Units


## Synopsis


A unit is basically an awk program that will scans its input and labels it.
It is completely in charge of everything, so you should read before using.
As a rule, A unit will mostly keep to itself, it will keep $0 intact (if possible or useful), but it will setup certain variables and functions, so be aware of not messing with those variables or the unit will fail. Since awk does not have capability for locals, such care is a necessity.
