#!/bin/bash

set -ouex pipefail

### Install packages
/ctx/01-build-packages.sh

systemctl enable podman.socket
