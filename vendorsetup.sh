#!/bin/bash

base64 -d device/xiaomi/alioth/configs/camera/secret > device/xiaomi/alioth/configs/camera/st_license.lic

# Clone kernel && setup kernelsu submodule
cd kernel/xiaomi/sm8250;
git submodule init;
git submodule update;
cd ../../../;
