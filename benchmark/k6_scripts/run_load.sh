#!/bin/bash

OUTPUT=influxdb=http://localhost:8086/k6

LOAD_ENDPOINT=$2
SIMULATION=$3

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

if [ $1 == test ]
then
    echo Running stress testing 
    k6 run --out $OUTPUT -e LOAD_ENDPOINT=$LOAD_ENDPOINT -e SIMULATION=$SIMULATION $SCRIPTPATH/test.js
fi

if [ $1 == stress ]
then
    echo Running stress testing 
    k6 run --out $OUTPUT -e LOAD_ENDPOINT=$LOAD_ENDPOINT -e SIMULATION=$SIMULATION $SCRIPTPATH/load_stress.js
fi

if [ $1 == spike ]
then
    echo Running spike testing 
    k6 run --out $OUTPUT -e LOAD_ENDPOINT=$LOAD_ENDPOINT -e SIMULATION=$SIMULATION $SCRIPTPATH/load_spike.js
fi


