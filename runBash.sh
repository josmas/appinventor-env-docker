docker run -ti -p 127.0.0.1:8888:8888 \
  -p 127.0.0.1:5037:5037 \
  -v /home/jos/code/MIT/app-inventor/:/home/ubuntu/app-inventor \
  --privileged \
  -v /dev/bus/usb:/dev/bus/usb \
  josmas/appinventor-dev /bin/bash
