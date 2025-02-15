ARCH=${shell uname -m}
FTD2XX_DIR=libftd2xx
FTD2XX_FILE=libftd2xx.tgz
SUDO=sudo
DOCKER_IMAGE=tmc-ide
CONTAINER_NAME=ide

# Detect the driver file to use
ifeq (${ARCH}, x86_64)
	FTD2XX_LIB=${FTD2XX_DIR}/libftd2xx-x86_64-1.4.27.tgz
else ifeq (${ARCH}, x86_32)
	FTD2XX_LIB=${FTD2XX_DIR}/libftd2xx-x86_32-1.4.27.tgz
else ifeq (${ARCH}, armv6l)
	FTD2XX_LIB=${FTD2XX_DIR}/libftd2xx-arm-v6-hf-1.4.27.tgz
else ifeq (${ARCH}, armv7l)
	FTD2XX_LIB=${FTD2XX_DIR}/libftd2xx-arm-v7-hf-1.4.27.tgz
else ifeq (${ARCH}, aarch64)
	FTD2XX_LIB=libftd2xx-arm-v8-1.4.27.tgz
else
	FTD2XX_LIB=no
endif

all: restart ide

install: clean setup ide

clean:
	@rm -f ${FTD2XX_FILE} 2>/dev/null || true
	@${SUDO} docker stop ${CONTAINER_NAME} 2>/dev/null || true
	@${SUDO} docker rm ${CONTAINER_NAME} 2>/dev/null || true
	@${SUDO} docker rmi ${DOCKER_IMAGE} 2>/dev/null || true

info:
	@echo "Detected Architecture : ${ARCH}"
	@echo "Selected Driver : ${FTD2XX_LIB}"

find_arch:
	@make info
	@if [ "${FTD2XX_LIB}" -eq "no" ]; then \
		echo -e "This Makefile will not work on your architecture !"; \
		exit 1; \
	fi \
	@cp -f ${FTD2XX_LIB} ${FTD2XX_FILE}

setup:
	@${SUDO} docker build -t ${DOCKER_IMAGE} .
	@${SUDO} docker run -dit --name ${CONTAINER_NAME} \
		-e DISPLAY=${DISPLAY} \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		--pid=host --privileged \
		--device=/dev/ttyUSB0 --device=/dev/bus/usb:/dev/bus/usb \
		${DOCKER_IMAGE}
	@make start
	@${SUDO} docker exec -it ${CONTAINER_NAME} setup

start:
	@${SUDO} docker start ${CONTAINER_NAME} || true

restart:
	@${SUDO} docker restart ${CONTAINER_NAME}

ide:
	@make start
	@docker exec -it ${CONTAINER_NAME} ide

.PHONY: clean install start restart info find_arch setup ide

