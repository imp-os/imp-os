#!/bin/bash

# determine which generation/model/ISA is required
read -p "Pi 3 or Pi 4?     [3/4]   : " generation
if [ $generation = "3" ]
then
    read -p "Model B or B+?    [B/B+]  : " model
    read -p "32-bit or 64-bit? [32/64] : " isa
else
    # (the current pi-4 development is for model B, 64-bit only)
    model="B"
    isa=64
fi
model=${model,,}

# checkout the relevant branches of the repositories
(cd repos/armstubs     && git checkout pi)
(cd repos/basic        && git checkout pi)
(cd repos/bootloader07 && git checkout pi-${generation})
(cd repos/cli          && git checkout pi)
(cd repos/hello        && git checkout pi)
(cd repos/kernel       && git checkout pi-${generation})
(cd repos/sd-card      && git checkout pi-${generation}-${model}-${isa}bit)
(cd repos/stdlib       && git checkout pi)

# create the "build.sh" script (builds components and creates "image" folder)
case "pi-${generation}-${model}-${isa}bit" in
	"pi-3-b+-64bit")
		armstub="armstub8"
		;;
	"pi-3-b+-32bit")
		armstub="armstub8-32"
		;;
	*)
		armstub="armstub7"
esac
echo "(cd repos/armstubs     && make clean && make all)"        >  build.sh
echo "(cd repos/bootloader07 && make clean && make ${isa}-bit)" >> build.sh
echo "(cd repos/kernel       && make clean && make ${isa}-bit)" >> build.sh
echo "(cd repos/stdlib       && make clean && make ${isa}-bit)" >> build.sh
echo "(cd repos/basic        && make clean && make ${isa}-bit)" >> build.sh
echo "(cd repos/cli          && make clean && make ${isa}-bit)" >> build.sh
echo "(cd repos/hello        && make clean && make ${isa}-bit)" >> build.sh
echo "rm -rf image"                                             >> build.sh
echo "mkdir  image"                                             >> build.sh
echo "cp repos/sd-card/*                image/"                 >> build.sh
echo "cp repos/bootloader07/kernel*.img image/"                 >> build.sh
echo "cp repos/basic/basic.bin          image/"                 >> build.sh
echo "cp repos/cli/cli.bin              image/"                 >> build.sh
echo "cp repos/hello/hello.bin          image/"                 >> build.sh
echo "cp repos/kernel/kernel.bin        image/imp-os.img"       >> build.sh
echo "cp repos/armstubs/${armstub}.bin  image/"                 >> build.sh
$(chmod a+x build.sh)

echo "OK"
