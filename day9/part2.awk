#!/usr/bin/env awk -f

function alen(a,    k){
	k=0
	for(i in a){
		k++
	}
	return k
}

function skipit(){
	if(alen(numbers) == 1){return 1}
	if(ANS < FIND){return 1}
	if(ANS > FIND){return 2}
	if(ANS == FIND){return 0}
	return 3
}

function findans(){
	LOW=ANS
	HIGH=0
	for(number in numbers){
		if(numbers[number] < LOW){
			LOW=numbers[number]
		}
		if(numbers[number] > HIGH){
			HIGH=numbers[number]
		}
	}
	ANS=LOW+HIGH	
}

BEGIN{
	ANS=0
	COUNTER=0
	RANGE=1
	
	FIND=105950735
	#FIND=127
}

{
	numbers[COUNTER]=$0
	ANS+=numbers[COUNTER]
	COUNTER++
	RANGE++
	
	if(skipit() == 0){
		exit
	}else if(skipit() == 1){
		next
	}

	while(1){
		RANGE--
		ANS-=numbers[COUNTER-RANGE]
		delete numbers[COUNTER-RANGE]
		
		if(skipit() == 0){
			exit
		}
		if(skipit() == 1){
			break
		}
	}
}

END{
	findans()
	print ANS
}
