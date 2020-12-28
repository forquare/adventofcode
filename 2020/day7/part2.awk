#!/usr/bin/env awk -f

function alen(a,    k){
	k=0
	for(i in a){
		k++
	}
	return k
}

function cramem(colour,    bag, total, a, r, CHILD){
	gsub(/[^a-zA-Z]/, "", colour)
	for(bag in BAGS){
		split(bag, a, " ")
		if(a[1] ~ colour){
			if(BAGS[bag] != "NONE"){
				total+=BAGS[bag]+(BAGS[bag]*cramem(a[2]))
				if(CHILD == 1){
					total-=BAGS[bag]
					CHILD=0
				}
			} else {
				total+=1
				CHILD=1
			}
		}
		delete a
	}
	return total
}

BEGIN{
	FS="contain"
}

{
	gsub(/bag[s]?|\./, "", $0)
	gsub(/[^a-zA-Z]/, "", $1)

	if($2 ~ /no other/){
		BAGS[$1]="NONE"
		next
	}

	split($2, contained, ",")
	
	for(i in contained){
		split(contained[i], colours, " ")
		colour=colours[2] colours[3]
		gsub(/[^a-zA-Z]/, "", colour)
		BAGS[$1," ",colour]=colours[1]
		delete colours
	}
	
	delete contained
}


END{
	print cramem("shiny gold")
}
