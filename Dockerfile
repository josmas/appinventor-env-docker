FROM ubuntu:15.10

# Build with
#    docker build -t <your_name>/app-inventor-environment .

RUN apt-get update

RUN apt-get install -y curl unzip

# Install X11 //TODO (jos) don't need x11 anymore
RUN apt-get install -y x11-apps

# Install prerequisites
RUN apt-get install -y openjdk-8-jdk lib32z1 lib32ncurses5 libbz2-1.0 lib32stdc++6

# Install other useful tools
RUN apt-get install -y git vim ant sudo android-tools-adb

# Install phantomJS
RUN apt-get install -y phantomjs

# Clean up
RUN apt-get clean
RUN apt-get purge

# Set up some permissions. Replace 1000 with your user/groupid if it is different
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

# Set up USB device debugging (device is ID in the rules files)
COPY 51-android.rules /etc/udev/rules.d/
RUN chmod a+r /etc/udev/rules.d/51-android.rules

RUN curl 'https://storage.googleapis.com/appengine-sdks/featured/appengine-java-sdk-1.9.27.zip' > /tmp/appengine.zip && unzip -d /home/developer /tmp/appengine.zip && rm /tmp/appengine.zip

EXPOSE 8888 5037

USER developer
ENV HOME /home/developer
RUN cd $HOME

