#!/usr/bin/env awk -f

function alen(a,    k){
	k=0
	for(i in a){
		k++
	}
	return k
}

BEGIN{
	RS=""
	FS=""
	TOTAL=0
}

{
	GROUPCOUNT=1
	for(i = 1; i <= NF; i++){
		a[$i]++
		GROUPCOUNT+=match($i, /\n/)
	}
	
	for(entry in a){
		if(a[entry] == GROUPCOUNT){
			TOTAL++
		}
	}

	delete a
}

END{
	print TOTAL
}
