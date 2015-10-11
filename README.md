# Docker file for an App Inventor environment
This file creates a container with a full App Inventor development environment
on Linux (Ubuntu 15.10 wily, 64bits) with all dependencies, and all software
needed to run the server (including connecting to a device through USB).

## Software installed
  - openjdk-8-jdk
  - ant
  - appengine 1.9.27
  - adb
  - phantomJS
  - git
  - other needed dependencies

## Some assumptions
This file will create a container with all you need for development ***BUT*** the App Inventor source code. You are supposed to clone the sources onto your machine, which will then be shared as a volume mounted on the container. The current *runBash.sh* file is hardcoded to find the sources at */home/jos/development/AppInventor/app-inventor*. You should modify that path accordingly to your own local setup.


## Usage
1. build the image with:
		(sudo) docker build -t [your_name]/appinventor-dev

	This will create a docker container with all the software needed.

2. Modify the script *runBash.sh*

	You should change [your_name]/appinventor for the name you have used when building the container. Also, you should modify the location of your app inventor sources as you have cloned them onto your local machine (my path is /home/jos/development/AppInventor/ so that should be modified in the script).

3. run the script
		runBash.sh

	This will run a bash session.

### Notes on the volume being shared
I am sharing /home/jos/AppInventor/app-inventor <-- this needs to be
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
  - Add aliases for git and terminal
  - Create a script to simply run the server (for non-developers)
  - Create a bash script to run the server on the container (runLocal.sh, copied on creation)


## Attribution
This file was adapted from https://github.com/kelvinlawson/dockerfile-android-studio

Jos - October 2015
