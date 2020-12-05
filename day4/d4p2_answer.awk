#!/usr/bin/env awk -f

function isbetween(v, x, y){
	v=int(v)
	if(v >= x && v <= y){
		return 1
	}else{
		return 0
	}
}

BEGIN{
	RS=""
	FS="[ \n]"
	OFS="\t"
	TOTAL=0
	VALIDFIELDS=8
}

{
	for(i = 1; i <= NF; i++){
		split($i, a, ":")
		key=a[1]
		val=a[2]

		if(key == "byr"){if(isbetween(val, 1920, 2002)){}else{next}}
		if(key == "iyr"){if(isbetween(val, 2010, 2020)){}else{next}}
		if(key == "eyr"){if(isbetween(val, 2020, 2030)){}else{next}}

		if(key == "hgt"){
			if(val ~ /^[0-9]{3,3}cm$/){
				if(isbetween(val, 150, 193)){}else{next}
			}else if(val ~ /^[0-9]{2,2}in$/){
				if(isbetween(val, 59, 76)){}else{next}
			}else{
				next
			}
		}

		if(key == "hcl"){
			if(val ~ /^#[0-9a-f]{6,6}$/){}else{next}
		}

		if(key == "ecl" && val !~ /^amb$|^blu$|^brn$|^gry$|^grn$|^hzl$|^oth$/){next}

		if(key == "pid"){
			if(val ~ /^[0-9]{9,9}$/){}else{next}
		}
	}

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
