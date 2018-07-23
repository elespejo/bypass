# bypass
It uses iptables to redirect packets input from an interface(eth1) to local port.

## Usage

* Fetch the code
```
git clone https://github.com/meninasx86/bypass-x86.git
```

* Modify config by adding vps in `02-vps`
```
cd bypass
vim white/02-vps
```

* Run bypass
```
./bypass-control start eth1
```

* clean rule
```
docker exec -it router_bypass ./clean-rule eth1
```

* clean ipset
```
docker exec -it router_bypass ./clean-ipset
```
