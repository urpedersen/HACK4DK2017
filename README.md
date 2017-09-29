# HACK4DK2017
Code for HACK4DK 2017

## SQL note

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
SELECT ageYears,dateOfDeath,sex,hood,street,street_number,deathcause,latitude,longitude FROM hack4dk.hack4dk_burial_persons_deathcauses as d 
left join hack4dk_burial_person as p ON p.id = d.persons_id
left join hack4dk_burial_address as a on a.persons_id = p.id
left join hack4dk_burial_deathcauses as dc ON d.deathcauses_id = dc.id
left join PRB_koordinat as k ON a.street COLLATE utf8_danish_ci LIKE k.vejnavn AND a.street_number = k.vejnummer
where dc.deathcause like "%bsce%"
```
