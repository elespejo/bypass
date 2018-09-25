
ARCH := x86
USER := user
PASS := passwd
TAG := x.x.x
SRC_DIR := ./src

.PHONY: deploy build

build:
	docker build -t elespejo/bypass-${ARCH} -f ${SRC_DIR}/Dockerfile-${ARCH} ${SRC_DIR}

deploy:
	docker login -u ${USER} -p ${PASS}
	docker tag elespejo/bypass-${ARCH} elespejo/bypass-${ARCH}:${TAG}
	docker push elespejo/bypass-${ARCH}:${TAG}