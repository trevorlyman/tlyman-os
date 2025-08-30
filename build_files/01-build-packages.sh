#!/usr/bin/bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

# Install Packages
dnf5 -y install \
    btop \
    go


# Remove PPackes
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