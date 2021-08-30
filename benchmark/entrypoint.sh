#!/usr/bin/env bash
set -x

pid=0

# SIGTERM-handler
term_handler() {
  echo "finishing..." 
  docker-compose down
	exit 0
}

trap 'kill ${!}; term_handler' SIGTERM

docker-compose up -d --build --force-recreate influxdb jupyter
pid="$!"

# wait forever
while true
do
  tail -f /dev/null & wait ${!}
done

