#!/bin/bash

OUTPUT=influxdb=http://localhost:8086/k6

TEST=$1
LOAD_ENDPOINT=$2
TARGET=$3
SIMULATION=$4

PARAMETER_TYPE=$5
PARAMETER=$6

parameter_env=""

if [ $PARAMETER_TYPE == payload ]
then
    parameter_env="-e PAYLOAD=$PARAMETER"
fi

if [ $PARAMETER_TYPE == language ]
then
    parameter_env="-e LANGUAGE=$PARAMETER"
fi

if [ $PARAMETER_TYPE == memory ]
then
    parameter_env="-e MEMORY=$PARAMETER"
fi

if [ $PARAMETER_TYPE == fibonacci ]
then
    parameter_env="-e FNUMBER=$PARAMETER"
fi


SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

echo "Running test ($TEST) - $LOAD_ENDPOINT - $TARGET - identifier=$SIMULATION - $PARAMETER_TYPE=$PARAMETER"
K6_INFLUXDB_USERNAME=admin K6_INFLUXDB_PASSWORD=admin K6_INFLUXDB_INSECURE=true k6 -q run --out $OUTPUT -e LOAD_ENDPOINT=$LOAD_ENDPOINT -e TARGET=$TARGET -e SIMULATION=$SIMULATION $parameter_env $SCRIPTPATH/$TEST.js
