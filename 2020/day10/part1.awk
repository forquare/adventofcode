#!/usr/bin/env awk -f

function finddifferences(i,    j){
	if(ADAPTORS[i]){
		for(j=1; j <= MAXJOLTS; j++){
			if(ADAPTORS[i+j]){
				JOLTS[j]++
				break
			}
		}
	}
}

BEGIN{
	MAXJOLTS=3
	HIGHEST=0
}

{
	ADAPTORS[$0]=1
	if($0 > HIGHEST){
		HIGHEST=$0
	}
}

END{
	for(j=1; j <= MAXJOLTS; j++){
		JOLTS[j]=1
	}

	ADAPTORS[HIGHEST]=1
	for(i=0; i <= HIGHEST; i++){
		finddifferences(i)
	}
	print JOLTS[1]*JOLTS[3]
}
