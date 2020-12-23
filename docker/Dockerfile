# imp-os

# 1) use base image
FROM ubuntu:18.04

# 2) inject platform content
RUN  apt update && apt install -y xz-utils picocom git nano make
COPY resources/gcc-arm-8.3-2019.03-x86_64-aarch64-elf.tar.xz.* /
COPY resources/gcc-arm-8.3-2019.03-x86_64-arm-eabi.tar.xz.*    /
RUN  ls -v gcc-arm-8.3-2019.03-x86_64-aarch64-elf.tar.xz.* | xargs cat > gcc-arm-8.3-2019.03-x86_64-aarch64-elf.tar.xz
RUN  ls -v gcc-arm-8.3-2019.03-x86_64-arm-eabi.tar.xz.*    | xargs cat > gcc-arm-8.3-2019.03-x86_64-arm-eabi.tar.xz
RUN  xz  -d  gcc-arm-8.3-2019.03-x86_64-aarch64-elf.tar.xz
RUN  xz  -d  gcc-arm-8.3-2019.03-x86_64-arm-eabi.tar.xz
RUN  tar -xf gcc-arm-8.3-2019.03-x86_64-aarch64-elf.tar
RUN  tar -xf gcc-arm-8.3-2019.03-x86_64-arm-eabi.tar

