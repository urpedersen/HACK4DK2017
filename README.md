# Livet før døden (life before death)
af Rasmus K. Pedersen og Ulf R. Pedersen

Web-page: urp.dk/lfd

## 10000 københavnske skæbner

Når man går en tur på kirkegården mærker man sin egen dødelighed. 
Hver gravsten repræsentere en skæbne.
Her vil vi give beskueren den samme oplevelse.

## Data
Vi har lavet "small data" ud af "big data" - at får de enkelte fortællinger ud af store data om danmarks befolkning.
Dette gøres ved at kompinere dataset for at finde sammenfald.

Vi har kompineret to data set:
 * Politietsregisterblade fra København (1890-1923)
 * Begravelsesregister fra København (1861-1912)

Man kunne udvide fortællingerne om de enkelte personer med data fra
 * Aviser 
 * Døde i krigen

## More info

 * Det vil tage ca. 14 timer af gennemse alle skæbmer.

# Code for HACK4DK 2017
Most code is written for Processing. See subfolders for more.

## SQL snips

### Abort
```SQL
SELECT * FROM hack4dk.hack4dk_burial_persons_deathcauses as d 
left join hack4dk_burial_person as p ON p.id = d.persons_id
left join hack4dk_burial_address as a on a.persons_id = p.id
left join hack4dk_burial_deathcauses as dc ON d.deathcauses_id = dc.id
left join PRB_koordinat as k ON a.street COLLATE utf8_danish_ci LIKE k.vejnavn AND a.street_number = k.vejnummer
where dc.deathcause like "%abort%"
```

### Infektioner
```SQL
SELECT p.id,ageYears,dateOfDeath,sex,hood,street,street_number,deathcause,latitude,longitude, pos.position, pos.relationtype FROM hack4dk.hack4dk_burial_persons_deathcauses as d 
left join hack4dk_burial_person as p ON p.id = d.persons_id
left join hack4dk_burial_address as a on a.persons_id = p.id
left join hack4dk_burial_deathcauses as dc ON d.deathcauses_id = dc.id
left join PRB_koordinat as k ON a.street COLLATE utf8_danish_ci LIKE k.vejnavn AND a.street_number = k.vejnummer
left join hack4dk_burial_position as pos ON p.id = pos.person_id
where dc.deathcause like "%bsce%" or dc.deathcause like "%infek%"
```
### Spanske syge - data dætter er IKKE langt nok!
```SQL
SELECT p.id,ageYears,dateOfDeath,sex,hood,street,street_number,deathcause,latitude,longitude, pos.position, pos.relationtype FROM hack4dk.hack4dk_burial_persons_deathcauses as d 
left join hack4dk_burial_person as p ON p.id = d.persons_id
left join hack4dk_burial_address as a on a.persons_id = p.id
left join hack4dk_burial_deathcauses as dc ON d.deathcauses_id = dc.id
left join PRB_koordinat as k ON a.street COLLATE utf8_danish_ci LIKE k.vejnavn AND a.street_number = k.vejnummer
left join hack4dk_burial_position as pos ON p.id = pos.person_id
where dc.deathcause like "%nflue%" or dc.deathcause like "%neumo%"
```
### Erhverv på døde
```SQL
SELECT person_id,position,lastname,ageYears,dateOfDeath,yearOfBirth,civilstatus,sex,street,street_number,latitude,longitude FROM hack4dk.hack4dk_burial_position as d
#SELECT * FROM hack4dk.hack4dk_burial_position as d
left join hack4dk_burial_person as p ON p.id = d.person_id
left join hack4dk_burial_address as a on a.persons_id = p.id
left join PRB_koordinat as k ON a.street COLLATE utf8_danish_ci LIKE k.vejnavn AND a.street_number = k.vejnummer
where relationtype = "Eget erhverv"
```
### Rigtig mange coordinater
```SQL
SELECT firstnames,lastname,gender,day,month,year,latitude,longitude FROM hack4dk.hack4dk_police_person as p
left join hack4dk_police_address as a on a.person_id = p.id


SELECT person_id,firstnames,lastname,gender,street,number,day,month,year,latitude,longitude FROM hack4dk.hack4dk_police_person as p
left join hack4dk_police_address as a on a.person_id = p.id
Where latitude IS NOT NULL
```
### Døde i begge databaser. En masse info!
```
#SELECT bp.firstnames,bp.lastname,bp.dateOfDeath,pp.deathyear,pp.deathmonth,pp.deathday #For checking
SELECT bp.id,bp.firstnames,bp.lastname,bp.dateOfDeath,dc.deathcause,pp.id,pa.day,pa.month,pa.year,pa.full_address,pa.latitude,pa.longitude
#SELECT *
FROM hack4dk.hack4dk_police_person as pp
left join hack4dk_burial_person  as bp on bp.firstnames = pp.firstnames AND bp.lastname = pp.lastname AND  year(bp.dateOfDeath) = pp.deathyear and month(bp.dateOfDeath) = pp.deathmonth
left join hack4dk_police_address as pa on pp.id = pa.person_id
left join hack4dk_burial_persons_deathcauses as pdc on pdc.persons_id = bp.id
left join hack4dk_burial_deathcauses as dc on pdc.deathcauses_id = dc.id
where deathyear IS NOT NULL AND latitude IS NOT NULL
#where latitude IS NOT NULL

#CONCAT(deathyear,'-',deathmonth,'-',deathday)
```

### Heste er søde 
```SQL
SELECT p.id,p.firstnames, p.lastname, ageYears,dateOfDeath,sex,street,street_number,deathcause,latitude,longitude FROM hack4dk.hack4dk_burial_persons_deathcauses as d 
left join hack4dk_burial_person as p ON p.id = d.persons_id
left join hack4dk_burial_address as a on a.persons_id = p.id
left join hack4dk_burial_deathcauses as dc ON d.deathcauses_id = dc.id
left join PRB_koordinat as k ON a.street COLLATE utf8_danish_ci LIKE k.vejnavn AND a.street_number = k.vejnummer
left join hack4dk_burial_position as pos ON p.id = pos.person_id
```
###  Burial 
```SQL
SELECT person_id,firstnames,lastname,sex,civilstatus,position,relationtype,ageYears,yearOfBirth,dateOfDeath,dc.id,dc.deathcause,street,street_number,latitude,longitude,cemetary 
FROM hack4dk.hack4dk_burial_position as d
#SELECT * FROM hack4dk.hack4dk_burial_position as d
left join hack4dk_burial_person as p ON p.id = d.person_id
left join hack4dk_burial_deathcauses as dc on dc.id = p.id
left join hack4dk_burial_address as a on a.persons_id = p.id
where latitude is not null and p.dateOfDeath is not null
```

