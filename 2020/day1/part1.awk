#!/usr/bin/env awk -f

BEGIN {
	FS=RS;
	RS="";
	A=0;
	B=0;
}

{
	for(i = 1; i <= NF; i++){
		A=$i
		for(j = 1; j <= NF; j++){
			B=$j
			if(A+B == 2020){
				exit
			}
		}
	}
}

END {
	print A*B
}
