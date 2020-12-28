#!/usr/bin/env awk -f

function doop(){
	SWITCH=1
	for(i = 1; i <= COUNTER; i++){
		
		split(operations[i], a)
		
		if(REGISTER[i]){
			delete REGISTER
			SWITCH=1
			TOTAL=0
			i=0
			continue
		}

		REGISTER[i]=1

		if(a[1] ~ /^nop/){
			if(!OPREG[i] && SWITCH){
				a[1]="jmp"
				OPREG[i]=1
				SWITCH=0
			}else{
				continue
			}
		}

		if(a[1] ~ /^jmp/){
			if(!OPREG[i] && SWITCH){
				OPREG[i]=1
				SWITCH=0
				continue
			}
			if(a[2] ~ /\+/){
				sub(/\+/, "", a[2])
				i+=a[2]-1
			}else{
				sub(/-/, "", a[2])
				i-=a[2]+1
			}
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
	}
}

BEGIN{
	TOTAL=0
	COUNTER=0
}

{
	COUNTER++
	operations[COUNTER]=$0
}

END{
	doop()
	print TOTAL
}
