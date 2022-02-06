#!/bin/bash
master_count=`wc --lines < current.txt`

date=`date`
echo $master_count

echo "$date | INFO | Got master count as $master_count"
echo "$date | INFO | entering master loop"

for (( i=1; i<= $master_count ; i++ ))
do
	voltage=`sed ''$i'!d' voltage.txt`
	current=`sed ''$i'!d' current.txt`
	power_factor=`sed ''$i'!d' power_factor.txt`

	echo "$date | INFO | Got voltage value as $voltage"
        echo "$date | INFO | Got current  value as $current"
        echo "$date | INFO | Got power factor value as $power_factor"

	echo "voltage_$i:$voltage current_$i : $current power_factor_$i: $power_factor"
	

	API_PACKET='{
           
                     "dummy" : "6",
                     "voltage_value": "'$voltage'",
                     "current_value" : "'$current'",
                     "power_factor_value" : "'$power_factor'"


} '
echo "$date | INFO | API packet formed successfully API packet = :$API_PACKET"

echo $API_PACKET > req.json

res=`curl -i -X POST "Content-Type: application/json Accept:application/json" -d @req.json http://18.117.136.155:5080/vipPush/ekn004`

echo $res

done
# remove temp file
rm -f req.json
