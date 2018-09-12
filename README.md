# bypass

* It uses iptables to redirect packets input from an interface(eth1) to local port.
* It builds 2 docker images, `elespejo/bypass-x86` and `elespejo/bypass-rpi`, which are hosted in docker hub.


# Deployment ( for end user)

### Through script

* Fetch the code
  ```
  git clone https://github.com/elespejo/bypass.git
  ```

* Modify config by adding vps in `02-vps`
  ```
  cd bypass-x86
  vim conf/02-vps
  ```

* Run bypass
  ```
  ./ctl start <iface> <balance num> <base port> <arch>
  ```

  ```
  ./ctl start eth1 4 1020 x86
  ```

  ```
  ./ctl start eth1 4 1020 armv6
  ```

* Check the status
  ```
  ./ctl status
  ```

* Restart bypass service
  ```
  ./ctl restart <iface> <balance num> <bypass port> <arch>
  ```


### Through docker cli

* Start bypass
  ```
  docker run -itd --cap-add=NET_ADMIN --network=host --privileged --name=router_bypass -v ${conf_vol}:/bypass -e LAN=${lan} -e BALANCE_NUM=${balance_num} -e BASE_PORT=${base_port} elespejo/bypass-x86:develop
  ``` 

  or if running on `armv6`

  ```
  docker run -itd --cap-add=NET_ADMIN --network=host --privileged --name=router_bypass -v ${conf_vol}:/bypass -e LAN=${lan} -e BALANCE_NUM=${balance_num} -e BASE_PORT=${base_port} elespejo/bypass-armv6:develop
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

# Getting Started ( for developer )

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

* Docker
* Travis client

### Local Build

```
./build <arch>
```

### Built With Travis CI

* `.travis.yml` for build configuration
* `set_docker_account` and `.env` is for create docker credential

# Logistics

### Contributing

Please read [CONTRIBUTING.md](https://github.com/elespejo/bypass/blob/master/docs/CONTRIBUTING.md) for contributing.
For details on our [code of conduct](https://github.com/elespejo/bypass/blob/master/docs/CODE_OF_CONDUCT.md), and the process for submitting pull requests to us.

### Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the tags on this repository

### Authors

* **mateomartin1998** - *Initial work* - [elespejo](https://github.com/mateomartin)

See also the list of [contributors](https://github.com/elespejo/bypass/graphs/contributors) who participated in this project.

### Acknowledgments

See [Acknowledgments](https://github.com/elespejo/bypass/blob/master/docs/ACKNOWLEDGMENTS.md)


### License

This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/elespejo/bypass/blob/master/LICENSE.md) file for details


