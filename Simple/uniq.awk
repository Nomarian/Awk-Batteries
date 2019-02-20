#!/usr/bin/awk -f

last != $0 {
	last = $0
	print $0
}