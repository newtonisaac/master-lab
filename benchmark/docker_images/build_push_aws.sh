if [ ! "$BASH_VERSION" ]; then
  exec /bin/bash "$0" "$@"
  exit 0
fi

#!/bin/bash
set -euxo pipefail

region=eu-north-1
registry=314815142513.dkr.ecr.$region.amazonaws.com
aws ecr get-login-password --region $region | docker login --username AWS --password-stdin $registry

tag="$registry/servelessbench:${1}"

docker build --tag=$tag ./docker_images/${1}

docker push $tag
