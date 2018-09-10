# bypass
It uses iptables to redirect packets input from an interface(eth1) to local port.

## Usage

### Through script

* Fetch the code
```
git clone https://github.com/meninasx86/bypass-x86.git
```

* Modify config by adding vps in `02-vps`
```
cd bypass-x86
vim conf/02-vps
```

* Run bypass
```
./ctl start <iface> <balance num> <base port>
```

```
./ctl start eth1 4 1020
```

* Check the status
```
./ctl status
```

* Restart bypass service
```
./ctl restart <iface> <balance num> <bypass port>
```


### Through docker cli

* Start bypass
```
docker run -itd --cap-add=NET_ADMIN --network=host --privileged --name=router_bypass -v ${conf_vol}:/bypass -e LAN=${lan} -e BALANCE_NUM=${balance_num} -e BASE_PORT=${base_port} meninasx86/bypass-x86:test 
``` 
in which, 

  * `${conf_vol}` is the white list directory you should provide for `bypass-x86`
  * `${lan}` is the lan interface in your router
  * `${balance_num}` is the number of REDIRECT port iptables statistic module accepts
  * `${base_port}` is the started port REDIRECT uses, step is 10 

* Stop bypass
  * Clean rule
  ```
  docker exec -it router_bypass ./clean-rule 
  ```

  * Clean ipset
  ```
  docker exec -it router_bypass ./clean-ipset
  ```
