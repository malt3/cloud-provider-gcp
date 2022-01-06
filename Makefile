CLOUD_CONTROLLER_MANAGER_BIN_BAZEL = ./bazel-bin/cmd/cloud-controller-manager/linux_amd64_pure_stripped/cloud-controller-manager
CLOUD_CONTROLLER_MANAGER_BIN = ./cloud-controller-manager
IMAGE_NAME = ghcr.io/malt3/cloud-provider-gcp
IMAGE_TAG = v0.0.1

all: image

$(CLOUD_CONTROLLER_MANAGER_BIN_BAZEL):
	bazel build //cmd/cloud-controller-manager:cloud-controller-manager

$(CLOUD_CONTROLLER_MANAGER_BIN): $(CLOUD_CONTROLLER_MANAGER_BIN_BAZEL)
	cp $(CLOUD_CONTROLLER_MANAGER_BIN_BAZEL) $(CLOUD_CONTROLLER_MANAGER_BIN)

image: $(CLOUD_CONTROLLER_MANAGER_BIN)
	DOCKER_BUILDKIT=1 docker build --build-arg CLOUD_CONTROLLER_MANAGER_BIN=$(CLOUD_CONTROLLER_MANAGER_BIN) -t $(IMAGE_NAME):$(IMAGE_TAG) -t $(IMAGE_NAME):latest .

push:
	docker push ghcr.io/malt3/cloud-provider-gcp
