#!/usr/bin/env awk -f

function check(tocheck){
	MATCH=0
	for(i in PREAMBLE){
		for(j in PREAMBLE){
			if(PREAMBLE[i] != PREAMBLE[j] && PREAMBLE[i]+PREAMBLE[j] == tocheck){
				MATCH=1
				break
			}
		}
		if(MATCH){break}
	}
	if(!MATCH){
		ANS=tocheck
		exit
	}
}

BEGIN{
	ANS=0
	PREAMBLELEN=25
}

{
	if(COUNTER < PREAMBLELEN){
		PREAMBLE[COUNTER]=$0
		COUNTER++
		next
	}
	
	check($0)
	PREAMBLE[COUNTER]=$0
	delete PREAMBLE[COUNTER-PREAMBLELEN]
	COUNTER++
}

END{
	print ANS
}
