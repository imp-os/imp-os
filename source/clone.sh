# !/bin/bash

# clone repositories
(rm -rf repos)
(mkdir repos)
git clone https://github.com/imp-os/armstubs.git     repos/armstubs
git clone https://github.com/imp-os/basic.git        repos/basic
git clone https://github.com/imp-os/bootloader07.git repos/bootloader07
git clone https://github.com/imp-os/cli.git          repos/cli
git clone https://github.com/imp-os/hello.git        repos/hello
git clone https://github.com/imp-os/kernel.git       repos/kernel
git clone https://github.com/imp-os/sd-card.git      repos/sd-card
git clone https://github.com/imp-os/stdlib.git       repos/stdlib
