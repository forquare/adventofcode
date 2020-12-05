#!/usr/bin/env awk -f

function roundup(x,    y){
	y=int(x)
	return y+1
}


function calc(input, right, down,    i, LINE, POS, COUNTER, LENGTH, TOTAL){
	TOTAL=0
	COUNTER=0
	for(i = 1; i <= NR; i++){
		LINE=input[i]
		POS=(COUNTER*right)+1
		COUNTER++
		if(POS <= 1){
			LENGTH=length(LINE)
			continue
		}
		if(down > 1 && i % down != 1){
			COUNTER--
			continue
		}
		
		lengths=roundup(POS/LENGTH)
		for(j = 0; j < lengths; j++){
			LINE=LINE input[i]
		}
		
		CHAR=substr(LINE, POS, 1)
		if(CHAR == TREE){
			TOTAL++
		}
	}
	return TOTAL
}

BEGIN{
	OPEN="."
	TREE="#"
	COUNT=1
}

{
	LINES[COUNT]=$0
	COUNT++
}

END{
	TOTAL=1
	TOTAL*=calc(LINES, 1, 1)
	TOTAL*=calc(LINES, 3, 1)
	TOTAL*=calc(LINES, 5, 1)
	TOTAL*=calc(LINES, 7, 1)
	TOTAL*=calc(LINES, 1, 2)
	print TOTAL
}
