#!/usr/bin/env bash

set -eu

echo ">>> Starting the system"
docker-compose up -d

echo ">>> Running test without Electron logging"
docker-compose run --no-deps e2e /app/run.sh

echo ">>> Running test *with* Electron logging:  ELECTRON_ENABLE_LOGGING=true"
docker-compose run \
	       --no-deps \
	       -e ELECTRON_ENABLE_LOGGING=true \
	       --volume=/var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
	       --user="$(id -u):$(id -g)" \
	       e2e /app/run.sh

echo ">>> Stopping the system"
docker-compose down -v
