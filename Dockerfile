FROM influxdb:0.13
MAINTAINER nikodc (https://github.com/nikodc)

COPY influxdb.conf /etc/influxdb/influxdb.conf
COPY entrypoint.sh /entrypoint.sh

EXPOSE 8083 8086

VOLUME /var/lib/influxdb

ENTRYPOINT ["/entrypoint.sh"]