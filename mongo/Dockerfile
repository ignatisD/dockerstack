FROM mongo:latest

MAINTAINER Mahmoud Zalt <mahmoud@zalt.me>

COPY mongo.conf /usr/local/etc/mongo/mongo.conf

VOLUME /data/db /data/configdb
# start without authentication
#CMD ["mongod"]
# start with authentication enabled
#CMD ["mongod", "--auth"]

EXPOSE 27017

