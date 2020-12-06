#!/usr/bin/env awk -f

BEGIN {
	TOTAL=0
}

{
	PASS=$3
	CHAR=substr($2, 1, 1)
	split($1, a, "-")
	POS1=substr(PASS, a[1], 1)
	POS2=substr(PASS, a[2], 1)
	
	if(POS1 == CHAR || POS2 == CHAR){
		if(POS1 != POS2){
			TOTAL++
		}
	}
}

END {
	print TOTAL
}
