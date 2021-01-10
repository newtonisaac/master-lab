#!/bin/sh

echo Boundary starting ...

while [ ! $(curl -o /dev/null -s -w "%{http_code}\n" http://localhost:9200) = 200 ]
do
    sleep 5s
    echo ...
done 

echo Boundary started ...
