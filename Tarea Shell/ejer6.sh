#!/bin/sh
echo "Deme el numero"
read NUM
COUNT=1
while [ $NUM -gt 0 ]
do
	AUX=1
    for  i in $AUX
    do
    	A+="*"
    done
    echo "$A"
    let NUM-=1
    let AUX+=1
done
