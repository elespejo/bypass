# Generate configuration

### Download the configuration generator
You can download the generator package from web page or command line.

* From web:  
    Go to the [release page](https://github.com/elespejo/bypass/releases) of this project and download `bypass-confgenerator-[VERSION].zip`.

* From command line:  
    ```bash
    wget https://github.com/elespejo/bypass/releases/download/[VERSION]/bypass-confgenerator-[VERSION].zip
    ```
    e.g, download configuration generator of version 0.4.1
    ```bash
    wget https://github.com/elespejo/bypass/releases/download/0.4.1/bypass-confgenerator-0.4.1.zip
    ```

### Unzip
```bash
unzip bypass-confgenerator-[VERSION].zip
```
e.g,
```bash
unzip bypass-confgenerator-0.4.1.zip
```

### Create bypass conf-info

##### To create bypass conf-info, you can refer to template `bypass-info.yml`

```bash
cd bypass-confgenerator
vi bypass-info.yml
config:
  lan: br0 
  base_port: 2010
  number: 16
  
white:
  - filename: 03-vps
    content:
    - ip/net
    - ip/net

  - filename: 04-test
    content:
    - ip/net
    - ip/net
``` 
##### Explanation of `bypass-info.yml`
* [br0]: ethernet interface name for lan
* [2010]: first port used by bypass
* [16]: number of ports
* [03-vps] or [04-test]: filename of while list
* [ip/net]: ip/netmask in white list, e.g, `123.123.123.0/24` or `123.123.123.123/32`, there can be more than one ip/net list in content

### Generate configuration

* Check usage of bypass-confgenerator
```bash
python -m bypass_confgenerator.cli -h
```

* Generate configuration
```bash
python -m bypass_confgenerator.cli [conf-info] -d [destination]
```
e.g,
```bash
python -m bypass_confgenerator.cli ~/bypass-confgenerator/bypass-info.yml -d ~/bypass-conf
```

### Check configuration
```bash
tree [destination]
```
e.g,
```bash
tree ~/bypass-conf
bypass-conf
├── bypass-config.env
└── bypass_conf
    ├── 01-inner
    ├── 02-cn
    ├── 03-vps
    └── 04-test

```

Explanation of each file in bypass-conf
* `bypass-config.env`: define enviroment variable for docker compose file 
* `bypass_conf/01-inner`: default white list of cn
* `bypass_conf/02-cn` default white list for local network
* `bypass_conf/03-vps`: user defined white list, usually it contains the IP of vps 
* `bypass_conf/04-test`: user defined white list 




