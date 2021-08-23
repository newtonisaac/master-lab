if [ ! "$BASH_VERSION" ]; then
  exec /bin/bash "$0" "$@"
  exit 0
fi

#!/bin/bash
set -euxo pipefail

tag="docker.io/engisaacnewton/servelessbench:${1}"

docker build --tag=$tag ./programs/${1}

docker push $tag
