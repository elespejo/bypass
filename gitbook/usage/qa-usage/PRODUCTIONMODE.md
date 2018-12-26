# Production mode

**Please install [routing](https://hilanderas.github.io/routing/usage/quickstart/INSTALL.html) before going on**
### Download testflow packages and unzip
```
wget https://github.com/elespejo/bypass/releases/download/0.5.7/bypass-testflow-0.5.7.zip
unzip dnsmasq-testflow-0.5.7.zip
```

### Run test cases on x86

* Download packages
```
cd script
make -f basic.mk download
```

* Set test project and arch
```
make -f basic.mk set_arch ARCH=x86
make -f manage_prod.mk set_img_pkg
```

* Generate configuration 

	Update `br0` and path of whitelist-dir to current directory in info.yml before going on
```
make -f manage_prod.mk gen_proj_conf 
```

* Run test cases

```
make -f prod.mk test_install
make -f prod.mk test_reinstall
make -f prod.mk test_reuninstall
make -f prod.mk test_installafteruninstall
make -f prod.mk test_reboot_p1
make -f prod.mk test_reboot_p2
make -f prod.mk test_poweroff_p1
make -f prod.mk test_poweroff_p2
```

* Clean test environment
```
make -f basic.mk rm_download
make -f manage_prod.mk del_proj_conf
```



### Run test cases on armv6

* Download packages
```
cd script
make -f basic.mk download
```

* Set test project and arch
```
make -f basic.mk set_arch ARCH=armv6
make -f manage_prod.mk set_img_pkg
```

* Generate configuration 

	Update a info.yml file in current directory
```
make -f manage_prod.mk gen_proj_conf 
```
* Download images
```
docker pull elespejo/dnsmasq-armv6:0.9.5
```

* Run test cases

```
make -f prod.mk test_install
make -f prod.mk test_reinstall
make -f prod.mk test_reuninstall
make -f prod.mk test_installafteruninstall
make -f prod.mk test_reboot_p1
make -f prod.mk test_reboot_p2
make -f prod.mk test_poweroff_p1
make -f prod.mk test_poweroff_p2
```


* Clean test environment
```
make -f basic.mk rm_download
make -f manage_prod.mk del_proj_conf
```
