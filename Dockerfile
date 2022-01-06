FROM scratch
ARG CLOUD_CONTROLLER_MANAGER_BIN=./cloud-controller-manager
COPY ${CLOUD_CONTROLLER_MANAGER_BIN} /cloud-controller-manager
