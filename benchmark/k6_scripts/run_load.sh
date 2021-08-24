#!/bin/bash

OUTPUT=influxdb=http://localhost:8086/k6
#OUTPUT=json=../k6_scripts/results/my_test_result.json
#OUTPUT=csv=../k6_scripts/results/my_test_result.csv

TEST=$1
LOAD_ENDPOINT=$2
TARGET=$3
SIMULATION=$4

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

if [ $TEST == t1 ]
then
    echo "Running Teste de sobrecarga (T1) - $LOAD_ENDPOINT - $TARGET - identifier=$SIMULATION"
    K6_INFLUXDB_USERNAME=admin K6_INFLUXDB_PASSWORD=admin K6_INFLUXDB_INSECURE=true k6 run --out $OUTPUT -e LOAD_ENDPOINT=$LOAD_ENDPOINT -e TARGET=$TARGET -e SIMULATION=$SIMULATION $SCRIPTPATH/t1.js
fi

if [ $TEST == t2 ]
then
    echo "Teste de carga simultânea (T2) - $LOAD_ENDPOINT - $TARGET - identifier=$SIMULATION"
    K6_INFLUXDB_USERNAME=admin K6_INFLUXDB_PASSWORD=admin K6_INFLUXDB_INSECURE=true k6 run --out $OUTPUT -e K6_INFLUXDB_USERNAME=admin -e K6_INFLUXDB_PASSWORD=admin -e LOAD_ENDPOINT=$LOAD_ENDPOINT -e TARGET=$TARGET -e SIMULATION=$SIMULATION $SCRIPTPATH/t2_ramping.js
fi