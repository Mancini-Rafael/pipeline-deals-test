#!/bin/sh

set -e

echo "=== ENTRYPOINT ==="

COMMAND="$1"

echo "=== BUNDLING ==="
bundle check || bundle install --jobs 20 --retry 5

case "$COMMAND" in
  server)
    echo "=== RUNNING SERVER ==="
    rm -f /app/tmp/pids/server.pid
    rails s -p 3001 -b 0.0.0.0
    ;;
  test)
    echo "=== RUNNING TEST SUITE ==="
    bundle exec rspec spec
    ;;
  lint)
    echo "=== RUNNING LINTER ==="
    rubocop -a
    ;;
  *)
    echo "=== RUNNING COMAND  $*==="
    sh -c "$*"
    ;;
esac