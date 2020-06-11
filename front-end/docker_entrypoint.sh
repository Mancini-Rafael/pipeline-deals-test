#!/bin/sh

set -e

echo "=== DOCKER ENTRYPOINT FOR PIPELINE DEALS FRONT-END ==="

COMMAND="$1"

echo "=== INSTALLING DEPENDENCIES ==="
npm install
case "$COMMAND" in
  server)
    echo "=== RUNNING DEVELOPMENT SERVER ==="
    npm start
    ;;
  lint)
    echo "=== RUNNING LINTER ==="
    eslint src/**/*.js --ignore-pattern *.test.js
    ;;
  test)
    echo "=== RUNNING TEST SUITE ==="
    npm test
    ;;
  *)
    echo "=== RUNNING COMAND  $*==="
    sh -c "$*"
    ;;
esac