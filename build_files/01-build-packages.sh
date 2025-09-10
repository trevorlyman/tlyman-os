#!/usr/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

# Add package repos
sudo dnf5 install -y dnf-plugins-core
sudo dnf5 config-manager addrepo --from-repofile=https://rpm.releases.hashicorp.com/fedora/hashicorp.repo


# Install Packages
dnf5 -y install \
    btop \
    dotnet-sdk-9.0 \
    git \
    golang \
    htop \
    neovim \
    terraform


# Remove Packes
EXCLUDED_PACKAGES=(
    "android-tools" \
    "bcc" \
    "zsh" \
)

if [[ "${#EXCLUDED_PACKAGES[@]}" -gt 0 ]]; then
    readarray -t EXCLUDED_PACKAGES < <(rpm -qa --queryformat='%{NAME}\n' "${EXCLUDED_PACKAGES[@]}")
fi

# remove any excluded packages which are still present on image
if [[ "${#EXCLUDED_PACKAGES[@]}" -gt 0 ]]; then
    dnf5 -y remove "${EXCLUDED_PACKAGES[@]}"
else
    echo "No packages to remove."
fi


echo "::endgroup::"