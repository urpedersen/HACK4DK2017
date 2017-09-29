#!/bin/bash

# getting and scaling images
for i in $(seq 1 8);do
 wget http://cspic.smk.dk/globus/GLOBUS%202009/kks2008-7-$i.JPG
 convert kks2008-7-${i}.JPG -resize 200x200 img${i}.jpg
done



