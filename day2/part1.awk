#!/usr/bin/env awk -f

BEGIN {
	TOTAL=0
}

{
	split($1, a, "-")
	FROM=a[1]
	TO=a[2]
	CHAR=substr($2, 1, 1)
	PASS=$3
	
	nchar=gsub(CHAR, CHAR, PASS)
	if(nchar >= FROM && nchar <= TO){
		TOTAL++
	}
}

END {
	print TOTAL
}
