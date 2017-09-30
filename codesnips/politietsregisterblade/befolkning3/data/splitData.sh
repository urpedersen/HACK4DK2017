#!/bin/bash 

./clean.sh
mkdir -p pos

awk  '
BEGIN{
 FS = ",";
 OFS = FS;
}
{ if(NR>1){
	year = $9
	if(month!="NULL" && year!="NULL"){
		print $0 >> "pos/" year ".csv"
	}
 }
}' positions.csv | head

sed -i '1 i\person_id,firstnames,lastname,gender,street,number,day,month,year,latitude,longitude' pos/*

