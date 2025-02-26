# Docker file for an App Inventor environment

This file creates a container with a full App Inventor development environment
on Linux (Ubuntu 24.10 oracular, 64bits) with all dependencies, and all software
needed to run the server (including connecting to a device through USB).

## Software installed

- openjdk-11-jdk-headless
- ant
- appengine 1.9.98
- adb
- phantomJS
- git
- other needed dependencies

## Some assumptions

This file will create a container with all you need for development **_BUT_** the App Inventor source code. You are supposed to clone the sources onto your machine, which will then be shared as a volume mounted on the container. The current _runBash.sh_ file is hardcoded to find the sources at _/home/jos/code/MIT/app-inventor_. You should modify that path accordingly to your own local setup.

## Usage

1. build the image with:
   (sudo) docker build -t [your_name]/appinventor-dev .

   This will create a docker container with all the software needed.

   NOTE: if you are using an arm processor on mac, user the platform flag as follows:
   (sudo) docker build --platform linux/amd64 -t [your_name]/appinventor-dev .

2. Modify the script _runBash.sh_

   You should change [your_name]/appinventor-dev for the name you have used when building the container. Also, you should modify the location of your app inventor sources as you have cloned them onto your local machine (my path is /home/jos/code/MIT/ so that should be modified in the script).

3. run the script
   runBash.sh

   This will run a bash session.

Note that all the commands to compile, run tests or launch any of the servers must be run within the terminal that is connected to the running container.
The host computer does not have the required dependencies to run, or even compile, the App Inventor code.

### Notes on the volume being shared

I am sharing /home/jos/code/MIT/app-inventor <-- this needs to be
configurable //TODO (jos)

### Connecting a device through USB

Modify the file 51-android.rules to include the ID of the device you want to
connect.

### Opening an additional bash session on the same container

Figure out the hash of the container by running
(sudo) docker ps

Then run a second shell with
(sudo) docker exec -it [container_id] bash

## TODOs

- Add aliases for git, nvim and others as needed in the container
- Create a script to simply run the server (for non-developers)
- Create a bash script to run the build server on the container (runLocal.sh, copied on creation)
- Add ruby and bundler to the image for markdown dockerfile-android-studio
- Test if the USB permissions/rules file is still needed

## Attribution

This file was adapted from https://github.com/kelvinlawson/dockerfile-android-studio

Jos - October 2015
Jos - December 2024
