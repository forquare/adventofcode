#!/usr/bin/env awk -f

function finddifferences(source, dest,    a, adaptor, temp){
	if(source == dest){
		return 1
	}
	
	if(!CACHE[source]){
		split(ADAPTORS[source], a)
		for(adaptor in a){
			temp+=finddifferences(a[adaptor], dest)
		}
		CACHE[source]=temp
	}
	
	return CACHE[source]
}

function getchildren(value,    i, temp){
	for(i=value+1; i <= value+MAXJOLTS && i <= HIGHEST; i++){
		if(ADAPTORS[i]){
			temp=temp i "\t"
		}else{
			delete ADAPTORS[i]
		}
	}

	if(!temp){
		temp=1
	}

	return temp
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
	HIGHEST+=MAXJOLTS
	ADAPTORS[0]=1
	ADAPTORS[HIGHEST]=1

	for(adaptor in ADAPTORS){
		ADAPTORS[adaptor] = getchildren(adaptor)
	}

	print finddifferences(0, HIGHEST)
}
