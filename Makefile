IMAGE_NAME  ?= vsguts/php71-fpm
IMAGE_TAG   ?= extra_1.0.0

DEPEND_IMAGE = ubuntu:16.04

.SILENT: ;               # no need for @
.ONESHELL: ;             # recipes execute in same shell
.NOTPARALLEL: ;          # wait for this target to finish
.EXPORT_ALL_VARIABLES: ; # send all vars to shell
Makefile: ;              # skip prerequisite discovery

.DEFAULT_GOAL = build
.PHONY: update build run push

update:
	docker pull $(DEPEND_IMAGE)

build: update
	docker build \
		-t $(IMAGE_NAME):$(IMAGE_TAG) \
		--rm .

run:
	docker run \
		-p 8080:80 \
		-it $(IMAGE_NAME):$(IMAGE_TAG)

push:
	docker push $(IMAGE_NAME):$(IMAGE_TAG)

%:
	@:
