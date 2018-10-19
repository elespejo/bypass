#!/bin/bash

ip=$@

for ip in $@
do 
    echo $ip/32 >> 02-vps
done
