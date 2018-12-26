#!make
include .env
IMG_VERSION=latest

.PHONY: build_image_x86
build_image_x86:
	make -C ${TEST_PROJ} mk-image ARCH=x86


.PHONY: clean_image_x86
clean_image_x86:
	docker rmi ${ORG}/${PROJECT}-x86:${IMG_VERSION} || true

.PHONY: build_image_armv6
build_image_armv6:
	make -C ${TEST_PROJ} mk-image ARCH=armv6

.PHONY: clean_image_armv6
clean_image_armv6:
	docker rmi ${ORG}/${PROJECT}-armv6:${IMG_VERSION} || true


.PHONY: build_imgAPI_x86
build_imgAPI_x86:
	make -C ${TEST_PROJ} mk-deployment-x86 VERSION=${IMG_VERSION}
	mkdir ${BUILD_PKG} || true 
	mv ${TEST_PROJ}/${PROJECT}-imageAPI-x86-${IMG_VERSION}.zip ${BUILD_PKG}/
	unzip ${BUILD_PKG}/${PROJECT}-imageAPI-x86-${IMG_VERSION}.zip -d ${BUILD_PKG}

.PHONY: build_imgAPI_armv6
build_imgAPI_armv6:
	make -C ${TEST_PROJ} mk-deployment-armv6 VERSION=${IMG_VERSION}
	mkdir ${BUILD_PKG} || true 
	mv ${TEST_PROJ}/${PROJECT}-imageAPI-armv6-${IMG_VERSION}.zip ${BUILD_PKG}/
	unzip ${BUILD_PKG}/${PROJECT}-imageAPI-armv6-${IMG_VERSION}.zip -d ${BUILD_PKG}

.PHONY: build_confgen
build_confgen:
	make -C ${TEST_PROJ} mk-confgenerator VERSION=${IMG_VERSION}
	mkdir ${BUILD_PKG} || true 
	mv ${TEST_PROJ}/${PROJECT}-confgenerator-${IMG_VERSION}.zip ${BUILD_PKG}/
	unzip ${BUILD_PKG}/${PROJECT}-confgenerator-${IMG_VERSION}.zip -d ${BUILD_PKG}


.PHONY: build_dev_env_x86
build_dev_env_x86: clean_dev_env_x86 build_image_x86 build_imgAPI_x86 build_confgen status
	make -f basic.mk set_arch ARCH=x86

.PHONY: build_dev_env_armv6
build_dev_env_armv6: clean_dev_env_armv6 build_image_armv6 build_imgAPI_armv6 build_confgen status 
	make -f basic.mk set_arch ARCH=armv6

.PHONY: clean_pkg
clean_pkg:
	rm -rf ${BUILD_PKG} || true
	make -f manage_dev.mk status || true 

.PHONY: clean_dev_env_x86
clean_dev_env_x86: clean_image_x86 clean_pkg

.PHONY: clean_dev_env_armv6
clean_dev_env_armv6: clean_image_armv6 clean_pkg

.PHONY: status
status: 
	ls ${BUILD_PKG} || true
	docker images | grep ${PROJECT}


.PHONY: gen_proj_conf 
gen_proj_conf: del_proj_conf
	cd ${BUILD_PKG}/${PROJECT}-confgenerator && python3 -m confgenerator.cli -f ${PWD}/${TEST_INFO} -d ${PWD}/${TEST_CONF}
	ls ${TEST_CONF}

.PHONY: read_proj_conf
read_proj_conf:
	ls ${TEST_CONF}

.PHONY: del_proj_conf
del_proj_conf:
	rm -rf ${TEST_CONF}




