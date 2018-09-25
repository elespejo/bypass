#!/bin/bash

CUR_DIR=`cd $(dirname $0);pwd`

docker-compose -f $CUR_DIR/docker-compose.yml ps
docker-compose -f $CUR_DIR/docker-compose.yml logs

sudo iptables -t nat -S
sudo ipset list -n