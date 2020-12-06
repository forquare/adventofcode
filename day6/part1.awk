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
	gsub("\n", "", $0)
	for(i = 1; i <= NF; i++){
		a[$i]=1
	}
	
	TOTAL+=alen(a)
	delete a
}

END{
	print TOTAL
}
