if [ ! "$BASH_VERSION" ]; then
  exec /bin/bash "$0" "$@"
  exit 0
fi

#!/bin/bash
set -euxo pipefail

tag="eu.gcr.io/master-324309/servelessbench:${1}"

docker build --tag=$tag ./docker_images/${1}

docker push $tag
