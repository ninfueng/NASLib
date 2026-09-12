DATA_DIR:=${HOME}/datasets

.PHONY: docrun
docrun:
	docker run \
		-it \
		--rm \
		--gpus all \
		--ipc=host \
		-e DISPLAY=$${DISPLAY} \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-v ./:/workspace \
		-v ${DATA_DIR}:/workspace/data \
		-e NVIDIA_DRIVER_CAPABILITIES=utility,compute,graphics \
		-e QT_X11_NO_MITSHM=1 \
		naslib:latest

.PHONY: docbuild
docbuild:
	docker build \
		-t naslib:latest \
		-f Dockerfile .

.PHONY: docinit
docinit:
	pip3 install --no-build-isolation -v -e .
