#!/usr/bin/env awk -f

function upperhalf(x, y){
	return int((y-x)/2)+x
        
}

function lowerhalf(x, y){
	return int((y-x)/2)+1+x
}

function alen(a,    k){
	k=0
	for(i in a){
		k++
	}
	return k
}

BEGIN{
	TOTAL=0
	FS=""
}

{
	ROWUPPER=127
	ROWLOWER=0
	COLUPPER=7
	COLLOWER=0

	for(i = 1; i <= NF; i++){
		if($i == "F"){
			ROWUPPER=upperhalf(ROWLOWER, ROWUPPER)
		}
		if($i == "B"){
			ROWLOWER=lowerhalf(ROWLOWER, ROWUPPER)
		}
		if($i == "L"){
			COLUPPER=upperhalf(COLLOWER, COLUPPER)
		}
		if($i == "R"){
			COLLOWER=lowerhalf(COLLOWER, COLUPPER)
		}
	}
	
	MIX[ROWUPPER, COLUPPER]=ROWUPPER*8+COLUPPER
}

END{
	PREV=0
	NEXT=1
	for(r = 0; r <= 127; r++){
		for(c = 0; c <= 7; c++){
			if(MIX[r,c] == 0 && MIX[r,c-1] != 0 && MIX[r,c+1] !=0){
				print r*8+c
			}
		}
	}
}
