FTD2XX_DIR 		 = libftd2xx
FTD2XX_LIB 		 = ${FTD2XX_DIR}/libft4222-linux-1.4.4.221.tgz
SUDO 	   		?= sudo
DOCKER_IMAGE	?= tmc-ide
CONTAINER_NAME	?= ide

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

setup:
	@make find_arch
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

