#!/usr/bin/env awk -f

BEGIN{
	RS=""
	FS="[ \n]"
	TOTAL=0
	VALIDFIELDS=8
}

{
	if(VALIDFIELDS == NF){
		TOTAL++
		next
	}
	if($0 !~ /cid/){
		if(VALIDFIELDS == NF+1){
			TOTAL++
			next
		}
	}
}

END{
	print TOTAL
}
