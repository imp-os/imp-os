# imp-os

This repository acts as a one-stop solution to beginning with IMP OS.

It uses Docker to provide a ready-to-use development environment for IMP OS, and also provides two scripts that can be used to configure the development environment.

## Building the Development Environment

Having cloned this repository, providing Docker for Desktop (https://www.docker.com/products/docker-desktop) is installed, simply run the following command to have Docker build and deploy the development environment in container form:

```
docker-compose up -d
```

Once built and running, the container can be connected to at any time by running the following command:

```
docker exec -it imp-os /bin/bash
```

When within the running container, the /var/source folder is the default folder which contains both the ``clone.sh`` script and ``checkout.sh`` script. These can be used to clone all the IMP OS repositories, as well as configured the build environment for whichever Raspberry Pi IMP OS is to be built for (e.g. Raspberry Pi 3 Model B+, 64-bit).

## Using the Scripts

### clone.sh

This script must necessarily be run first. It requires no parameters to operate; it simply checks out all the IMP OS related repositories ready to use (e.g. kernel, bootloader07, basic, etc.)

### checkout.sh

Having run ``clone.sh``, this script will - when run - ask for whichever flavour of Raspberry Pi IMP OS is to be configured for.

By responding to the questions, the script will do two things. It will:

  * checkout the relevant branch within each of the IMP OS repositories
  * create a ``build.sh`` script that can be used to build IMP OS in its entirety
  
Like ``clone.sh``, this is really just a 'convenience' script that saves having to recall which branches of which repositories need to be checked out for the various target environments, preventing mismatched builds.

## Deploying to Raspberry Pi

When run, the ``build.sh`` script will take the output of the repository builds and produce an "image" folder that contains all the files required to run IMP OS.

The content of this folder may be copied to a standard FAT-32 SD card and fired up on the relevant target environment.

