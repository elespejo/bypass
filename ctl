#!/bin/bash
filename="$0"
image="meninasx86/bypass-x86"
version="test"
conf_vol=`pwd`/conf
container=bypass_router

Usage() {
    echo "Usage: $filename <command> <attribute>"
    echo "command options:"
    echo "  start   start  service"
    echo "  stop    stop  service"
    echo "  status  display the status of service"
    echo "attribute options:"
    echo "  iface   interface of wan"
    echo "  port(range) port or port range of dns service    "
    exit 1
}

START() {
    if [ "$#" -ne 3 ]; then
        Usage
    fi
    lan=$1 
    balance_num=$2
    base_port=$3

    docker run -itd --cap-add=NET_ADMIN --network=host --privileged --name=${container} -v ${conf_vol}:/bypass -e LAN=${lan} -e BALANCE_NUM=${balance_num} -e BASE_PORT=${base_port} ${image}:${version}
}

STOP() {
    if [ "$#" -ne 0 ]; then
        Usage
    fi

    docker exec -it ${container} ./clean-rule
    docker exec -it ${container} ./clean-ipset
    docker rm -f ${container}
}

STATUS() {
    docker ps -a | grep ${container}
    sudo iptables -L -nv -t nat
    sudo ipset list -n
}

if [ "$#" -lt 1 ]; then
    Usage
else
    case "$1" in
        start)
            START $2 $3 $4
            sleep 5
            STATUS
            ;;
        stop)
            STOP
            sleep 5
            STATUS
            ;;
        restart)
            STOP
            START $2 $3 $4
            sleep 5
            STATUS
            ;;
        status)
            STATUS
            ;;       
        *)
            Usage
            ;;
    esac
fi
