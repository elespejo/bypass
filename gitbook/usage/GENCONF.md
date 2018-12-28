# Generate configuration

### Download the configuration generator
You can download the generator package from web page or command line.

* From web:  
    Go to the [release page](https://github.com/elespejo/bypass/releases) of this project and download `bypass-confgenerator-[VERSION].zip`.

* From command line:  
    ```bash
    wget https://github.com/elespejo/bypass/releases/download/[VERSION]/bypass-confgenerator-[VERSION].zip
    ```
    e.g, download configuration generator of version 0.5.6
    ```bash
    wget https://github.com/elespejo/bypass/releases/download/0.5.6/bypass-confgenerator-0.5.6.zip
    ```

### Unzip
```bash
unzip bypass-confgenerator-[VERSION].zip
cd bypass-confgenerator/
```
e.g,
```bash
unzip bypass-confgenerator-0.5.6.zip
cd bypass-confgenerator/
```

### Create bypass conf-info

To create bypass conf-info, you can refer to template `bypass-info.yml` in `bypass-confgenerator/`
```bash
cd bypass-confgenerator
vi bypass-info.yml
```
The `bypass-info.yml` looks like following:
```yaml
config:
  lan: br0
  base_port: 2010
  number: 4
  
bypass-vps:
  - ip/net
  - ip/net

whitelist-dir:  /home/USER/white-dir
``` 
Explanation of `bypass-info.yml`
* [lan]: ethernet interface name for your machine's lan
* [base_port]: first port used by bypass
* [number]: number of ports (**As info template above, 4 ports will be configured as 2010, 2020, 2030, 2040.**)
* [bypass-vps]: ip/netmask in white list, e.g, `123.123.123.0/24` or `123.123.123.123/32`, there can be more than one ip/net list
* [whitelist-dir]: the path of extra configuration files

    

### Generate configuration

* Check usage of bypass-confgenerator
    ```bash
    python -m confgenerator.cli -h
    ```

* Generate configuration
    ```bash
    python -m confgenerator.cli -f [conf-info] -d [destination]
    ```
    e.g,
    ```bash
    python -m confgenerator.cli -f ~/bypass-confgenerator/bypass-info.yml -d ~/bypass-conf
    ```

### Check configuration
```bash
tree [destination]
```
e.g,
```bash
tree ~/bypass-conf
bypass-conf
├── config.env
└── conf
    ├── 01-inner
    ├── 02-cn
    ├── vps
    └── extraconf
```

Explanation of each file in bypass-conf
* `config.env`: define environment variable for docker compose file 
* `conf/01-inner`: default white list of cn
* `conf/02-cn` default white list for local network
* `conf/vps`: user defined white list, usually it contains the IP of vps 
* `conf/extraconf`: configuration in whitelist-dir
