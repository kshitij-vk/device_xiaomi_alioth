#!/bin/bash

# Decode and write the secret license file
base64 -d device/xiaomi/alioth/configs/camera/secret > device/xiaomi/alioth/configs/camera/st_license.lic

# Clone kernel and setup kernelsu submodule
if [ ! -d "kernel/xiaomi/sm8250" ]; then
  git clone https://github.com/EmanuelCN/kernel_xiaomi_sm8250.git -b staging kernel/xiaomi/sm8250
  cd kernel/xiaomi/sm8250
  git submodule init
  git submodule update
  cd ../../../
else
  echo "Kernel already exists, skipping cloning."
fi

# Setup clang and antman
if [ ! -d "prebuilts/clang/host/linux-x86/clang-neutron" ]; then
  mkdir -p prebuilts/clang/host/linux-x86/clang-neutron
  cd prebuilts/clang/host/linux-x86/clang-neutron
  curl -LO "https://raw.githubusercontent.com/Neutron-Toolchains/antman/main/antman"
  chmod +x antman
  ./antman -S
else
  echo "Clang already exists, skipping setup."
fi

# Check if the system is not Arch Linux before running the patch command
if ! grep -q "Arch" /etc/os-release; then
  cd prebuilts/clang/host/linux-x86/clang-neutron
  ./antman --patch=glibc
fi

cd ../../../../../
