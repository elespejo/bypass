# Deployment

### Download the deployment package
    
You can download the deployment package from web page or command line.

* From web:  
Go to the [release page](https://github.com/elespejo/bypass/releases) of this project. Select the package according to the architecture of your machine.

* From command line:  
```bash
wget https://github.com/elespejo/bypass/releases/download/[VERSION]/bypass-[ARCH]-[VERSION].zip
```
  * VERSION : the release tag  
  * ARCH : the architecture of your machine 

  e.g : Deploy a bypass on a x86 machine with the release 0.4.1 by executing
  ```bash
  wget https://github.com/elespejo/bypass/releases/download/0.4.1/bypass-x86-0.4.1.zip
  ```

### Unzip

```bash
unzip bypass-[ARCH]-[VERSION].zip
cd bypass-imageAPI-[ARCH]
```

### Generate the docker compose file

Docker compose file is used for bypass deployment. Its generation requires two parameters:
* [CONF_PATH]: The absolute path to configuration directory.  
* [COMP_NAME]: The name of docker compose file you are going to be generated.

```bash
make config CONFIG=[CONF_PATH] NAME=[COMP_NAME]
```

e.g : Generate a compose file named `bypass.yml` with the configuration in `~/bypass-conf/`.
```bash
cd ~/bypass-imageAPI-x86/
make config CONFIG=~/bypass-conf/ NAME=bypass
```
Therefore a compose file named `bypass.yml` is generated in `~/bypass-imageAPI-x86/compose/`.
```yaml
# bypass.yml
services:
  router_bypass:
    cap_add:
    - NET_ADMIN
    environment:
      BALANCE_NUM: '16'
      BASE_PORT: '2010'
      LAN: br0
    image: elespejo/bypass-x86:0.4.1
    network_mode: host
    restart: always
    stdin_open: true
    volumes:
    - source: ~/bypass_conf
      target: /bypass
      type: bind
version: '3.2'
```

### Start the service
Start the service with the name you specified in the config step above.
```bash 
make start NAME=[COMP_NAME]
```
e.g: start service `bypass`
```bash
cd bypass-imageAPI-x86/
make start NAME=bypass
```
After starting the service successfully, you may see the output similar with the following: 
```
docker-compose -p bypass -f ~/bypass-imageAPI-x86/compose/bypass.yml up -d
Pulling router_bypass (elespejo/bypass-x86:0.4.1)...
0.4.1: Pulling from elespejo/bypass-x86
...
Status: Downloaded newer image for elespejo/bypass-x86:0.4.1
Creating bypass_router_bypass_1 ... done
```

### Restart the service
```bash
make restart NAME=[COMP_NAME]
```
e.g
```bash
make restart NAME=bypass
```
After restarting the service successfully, you may see the output similar with the following:
```
docker-compose -p bypass -f ~/bypass-imageAPI-x86/compose/bypass.yml up -d --force-recreate
Recreating bypass_router_bypass_1 ... done
```

### Check status of the service
```bash
make status NAME=[COMP_NAME]
```
e.g,
```bash
make status NAME=bypass
```
You may see the output similar with the following:
```
docker-compose -p bypass -f ~/bypass-imageAPI-x86/compose/bypass.yml ps
        Name                Command          State      Ports
-------------------------------------------------------------
bypass_router_bypass_1   /bin/sh -c ./init      UP
docker-compose -p bypass -f ~/bypass-imageAPI-x86/compose/bypass.yml logs
Attaching to bypass_router_bypass_1
...
```

### Stop the service
```bash
make stop NAME=[COMP_NAME]
```
e.g,
```bash
make stop NAME=bypass
```
After stoping the service successfully, you may see the output similar with the following:
```
docker-compose -p bypass -f ~/bypass-imageAPI-x86/compose/bypass.yml down
Stopping bypass_router_bypass_1 ... done
Removing bypass_router_bypass_1 ... done
```

### List the services
```bash
make list
```
You may see the output similar with the following:
```
for compose in `ls ~/bypass-imageAPI-x86/compose`;do name=`echo $compose|awk -F "." '{print $1}'`;echo $name;docker-compose -p $name -f ~/bypass-imageAPI-x86/compose/$compose ps;done
bypass
Name   Command   State   Ports
------------------------------
...
```

### Remove the compose file
```bash
make remove NAME=[COMP_NAME]
```
e.g,
```bash
make remove NAME=bypass
```
You may see the output similar with the following:
```
rm ~/bypass-imageAPI-x86/compose/bypass.yml
```
Check whether the remove step successfully:
```bash
ls compose | grep bypass
```

