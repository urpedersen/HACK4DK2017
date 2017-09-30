#!/bin/bash 

./clean.sh
mkdir -p pos

awk  '
BEGIN{
 FS = ",";
 OFS = FS;
}
{ if(NR>1){
	month = $5
	year = $6
	if(month!="NULL" && year!="NULL"){
		print $0 >> "pos/" year month ".csv"
	}
 }
}' positions.csv | head

sed -i '1 i\firstnames,lastname,gender,day,month,year,latitude,longitude' pos/*

