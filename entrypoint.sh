#!/bin/bash

set -m
INFLUX_HOST="localhost"
INFLUX_API_PORT="8086"
INFLUX_API_URL="http://${INFLUX_HOST}:${INFLUX_API_PORT}"
INFLUX_API_PING_URL="${INFLUX_API_URL}/ping"
INTERNAL_ADMIN_USER=admin
INTERNAL_ADMIN_PASS=changeme

if [ -n "${ADMIN_USER}" ]; then
    INTERNAL_ADMIN_USER=${ADMIN_USER}
fi
if [ -n "${ADMIN_PASS}" ]; then
    INTERNAL_ADMIN_PASS=${ADMIN_PASS}
fi

echo "=> Starting InfluxDB ..."
exec influxd &

# Wait for InfluxDB startup confirmation
RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of InfluxDB service startup ..."
    sleep 3
    curl -k ${INFLUX_API_PING_URL} 2> /dev/null
    RET=$?
done
echo "=> InfluxDB service startup confirmation received."

# Create admin user
echo "=> About to create admin user: ${INTERNAL_ADMIN_USER} ..."
if [ -f "/.admin_user_created" ]; then
    echo "=> Admin user already exists, skipping."
else
    echo "=> Creating admin user..."
    influx -host=${INFLUX_HOST} -port=${INFLUX_API_PORT} -execute="CREATE USER ${INTERNAL_ADMIN_USER} WITH PASSWORD '${INTERNAL_ADMIN_PASS}' WITH ALL PRIVILEGES"
    echo "=> Admin user created."
    touch "/.admin_user_created"
fi

fg