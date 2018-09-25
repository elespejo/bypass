
<p align="center">
  <img src="https://www.lucidchart.com/publicSegments/view/e989f28a-2be0-4032-b578-8e0e05b3e7b7/image.png">
</p>

<h1 align="center"> bypass </h1>
<p align="center">
  <b > route packets using iptables </b>
</p>
<br>

![Travis (.org) branch](https://img.shields.io/travis/elespejo/bypass/master.svg)
![GitHub](https://img.shields.io/github/license/elespejo/bypass.svg)

`   armv6:   `
[![Docker Pulls](https://img.shields.io/docker/pulls/elespejo/bypass-armv6.svg)](https://hub.docker.com/r/elespejo/bypass-armv6/tags/)

`   x86:    `
[![Docker Pulls](https://img.shields.io/docker/pulls/elespejo/bypass-x86.svg)](https://hub.docker.com/r/elespejo/bypass-x86/tags/)

* It uses iptables to redirect packets input from an interface(eth1) to local port.
* It builds 2 docker images, `elespejo/bypass-x86` and `elespejo/bypass-rpi`, which are hosted in docker hub.


# Deployment ( for end user)

### Through docker-compose

* Fetch the code
  ```
  $ git clone https://github.com/elespejo/bypass.git
  ```

* Modify config by adding vps in `02-vps`
  ```
  $ cd bypass/test
  $ vim conf/02-vps
  ```

* Modify the architecture and version
  ```
  $ vim .env
  ```

* Run bypass
  ```
  $ docker-compose up -d 
  ```

* Check the status
  ```
  $ ./check_status.sh
  ```

* Restart bypass service
  ```
  $ docker-compose up -d --force-recreate
  ```


### Through docker cli

* Start bypass
  ```
  $ docker run -itd --cap-add=NET_ADMIN --network=host --privileged --name=router_bypass -v ${conf_vol}:/bypass -e LAN=${lan} -e BALANCE_NUM=${balance_num} -e BASE_PORT=${base_port} elespejo/bypass-x86:test
  ``` 

  or if running on `armv6`

  ```
  $ docker run -itd --cap-add=NET_ADMIN --network=host --privileged --name=router_bypass -v ${conf_vol}:/bypass -e LAN=${lan} -e BALANCE_NUM=${balance_num} -e BASE_PORT=${base_port} elespejo/bypass-armv6:test
  ``` 
  in which, 

    * `${conf_vol}` is the white list directory you should provide for `bypass-x86`
    * `${lan}` is the lan interface in your router
    * `${balance_num}` is the number of REDIRECT port iptables statistic module accepts
    * `${base_port}` is the started port REDIRECT uses, step is 10 

* Stop bypass
  * Clean rule
    ```
    $ docker-compose exec router_bypass ./clean-rule 
    ```

  * Clean ipset
    ```
    $ docker-compose exec router_bypass ./clean-ipset
    ```

  * Stop compose or container
    ```
    $ docker-compose down
    ```
    or 
    ```
    $ docker rm -f router_bypass
    ```

# Getting Started ( for developer )

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

* Docker
* Travis client

### Local Build

```
$ make build
```

### Built With Travis CI

* `.travis.yml` for build configuration

# Logistics

### Contributing

Please read [CONTRIBUTING.md](https://github.com/elespejo/bypass/blob/master/docs/CONTRIBUTING.md) for contributing.
For details on our [code of conduct](https://github.com/elespejo/bypass/blob/master/docs/CODE_OF_CONDUCT.md), and the process for submitting pull requests to us.

### Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the tags on this repository

### Authors

* **mateomartin1998** - *Initial work* - [elespejo](https://github.com/mateomartin)
* **Valerio-Perez** - *Organize* - [Valerio-Perez](https://github.com/Valerio-Perez)

See also the list of [contributors](https://github.com/elespejo/bypass/graphs/contributors) who participated in this project.

### Acknowledgments

See [Acknowledgments](https://github.com/elespejo/bypass/blob/master/docs/ACKNOWLEDGMENTS.md)


### License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/elespejo/bypass/blob/master/LICENSE.md) file for details


