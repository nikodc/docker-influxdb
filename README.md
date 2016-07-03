# docker-influxdb
Custom InfluxDB Docker image based on https://hub.docker.com/_/influxdb/

## Running

Run like this:

```
docker run -d -p 8083:8083 -p 8086:8086 --name influxdb nikodc/docker-influxdb:latest
```

... to create a container running InfluxDB with authentication enabled and credentials: admin / changeme .

In order to override the default credentials, run like this:

```
docker run -d -p 8083:8083 -p 8086:8086 -e ADMIN_USER="root" -e ADMIN_PASS="root1234" --name influxdb nikodc/docker-influxdb:latest
```