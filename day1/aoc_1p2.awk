#!/usr/bin/env awk -f

function alen(a,    k){
	k=0
	for(i in a){
		k++
	}
	return k
}

function doCheck(count, input,    sumlist, slindex, iteration, entry, i, sum){
	iteration=alen(sumlist)

	for(entry in input){
		sumlist[iteration] = input[entry]
		slindex[iteration] = entry
		if(alen(sumlist) == count){
			#for(i in sumlist){ printf "%i\t",sumlist[i] }
			#printf "\n"
			#exit
			sum=0
			TOTAL=1
			for(i in sumlist){
				sum+=sumlist[i]
				TOTAL*=sumlist[i]
			}

			#printf "CALC: %s%i  %s%i  %s%i\n","iteration=",iteration,"count=",count,"calc=",sum
			if(sum == 2020){
				printf "2020: %s%i  %s%i\n","iteration=",iteration,"count=",count
				exit
			}
		} else {
			doCheck(count, input, sumlist, slindex)
		}
		delete sumlist[iteration]
		delete slindex[iteration]
	}
	return
}

BEGIN {
	FS=RS
	RS=""
	TOTAL=0
}

{
	split($0, inarray, FS)
	doCheck(3, inarray)
}

END {
	print TOTAL
}
