#!/bin/bash

base64 -d device/xiaomi/alioth/configs/camera/secret > device/xiaomi/alioth/configs/camera/st_license.lic

# Clone kernel && setup kernelsu submodule
git clone https://github.com/EmanuelCN/kernel_xiaomi_sm8250.git -b staging kernel/xiaomi/sm8250;
cd kernel/xiaomi/sm8250;
git submodule init;
git submodule update;
cd ../../../;

# Setup clang and antman
mkdir -p prebuilts/clang/host/linux-x86/clang-neutron
cd prebuilts/clang/host/linux-x86/clang-neutron
curl -LO "https://raw.githubusercontent.com/Neutron-Toolchains/antman/main/antman"
chmod +x antman
./antman -S


# Check if the system is not Arch Linux before running the patch command
if ! grep -q "Arch" /etc/os-release; then
  ./antman --patch=glibc
fi

cd ../../../../../
