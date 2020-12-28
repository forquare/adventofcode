#!/usr/bin/env awk -f

function alen(a,    k){
	k=0
	for(i in a){
		k++
	}
	return k
}

function findcolour(colour,    bag, a){
	for(bag in BAGS){
		split(bag, a, "  ")
		if(a[2] ~ colour){
			findcolour(a[1])
			FINALBAGS[a[1]]++
		}
		delete a
	}
}

BEGIN{
	FS="contain"
}

$2 !~ /no other/{
	gsub(/bag[s]?|\./, "", $0)
	split($2, contained, ",")
	
	for(i in contained){
		split(contained[i], colours, " ")
		colour=colours[2] " " colours[3]
		BAGS[$1,colour]=colours[1]
		delete colours
	}
	
	delete contained
}


END{
	findcolour("shiny gold")
	print alen(FINALBAGS)
}
