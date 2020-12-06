#!/usr/bin/env awk -f

function alen(a,    k){
	k=0
	for(i in a){
		k++
	}
	return k
}

function doCheck(count,    sumlist, current, iteration, entry, i, sum){
	iteration=alen(sumlist)
	
	if(current < 1){
		current = 1
	}

	for(entry = current; entry <= NF; entry++){
		sumlist[iteration] = $entry
		if(alen(sumlist) == count){
			sum=0
			TOTAL=1
			for(i in sumlist){
				sum+=sumlist[i]
				TOTAL*=sumlist[i]
			}
			if(sum == 2020){
				exit
			}
		} else {
			doCheck(count, sumlist, current)
		}
		delete sumlist[iteration]
	}
	return
}

BEGIN {
	FS=RS
	RS=""
	TOTAL=0
}

{
	doCheck(3)
}

END {
	print TOTAL
}
