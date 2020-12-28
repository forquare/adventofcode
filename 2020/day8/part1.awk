#!/usr/bin/env awk -f

function check(i){
	if(REGISTER[i]){
		return 1
	}
	return 0
}

function doop(i){
	for(i = 1; i <= COUNTER; i++){
		split(operations[i], a)
		
		if(check(i)){
			return
		}

		REGISTER[i]=1

		if(a[1] ~ /^nop/){
			continue
		}

		if(a[1] ~ /^acc/){
			if(a[2] ~ /\+/){
				sub(/\+/, "", a[2])
				TOTAL+=a[2]
			}else{
				sub(/-/, "", a[2])
				TOTAL-=a[2]
			}
		}

		if(a[1] ~ /^jmp/){
			if(a[2] ~ /\+/){
				sub(/\+/, "", a[2])
				i+=a[2]-1
			}else{
				sub(/-/, "", a[2])
				i-=a[2]+1
			}
		}
	}
}

BEGIN{
	TOTAL=0
	COUNTER=0
	REGISTER[0]=1
}

{
	COUNTER++
	operations[COUNTER]=$0
}

END{
	doop()
	print TOTAL
}
