#!/usr/bin/env awk -f

function roundup(x,    y){
	y=int(x)
	return y+1
}

BEGIN{
	TOTAL=0
	OPEN="."
	TREE="#"
	RIGHT=3
	COUNT=0
	LENGTH=0
}

{
	LINE=$0
	POS=(COUNT*RIGHT)+1
	COUNT++
	if(POS <= 1){
		LENGTH=length(LINE)
		next
	}
	
	lengths=roundup(POS/LENGTH)
	for(j = 0; j < lengths; j++){
		LINE=LINE $0
	}
	
	CHAR=substr(LINE, POS, 1)
	if(CHAR == TREE){
		TOTAL++
	}
}

END{
	print TOTAL
}
