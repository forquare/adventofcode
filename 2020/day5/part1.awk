#!/usr/bin/env awk -f

function upperhalf(x, y){
	return int((y-x)/2)+x
        
}

function lowerhalf(x, y){
	return int((y-x)/2)+1+x
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
	temp=ROWUPPER*8+COLUPPER
	if(temp > TOTAL){
		TOTAL=temp
	}
}

END{
	print TOTAL
}
