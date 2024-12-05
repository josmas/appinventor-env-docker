FROM ubuntu:24.10

# Build with
#    docker build -t <your_name>/app-inventor-dev .

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
  curl unzip openjdk-11-jdk-headless lib32z1 libbz2-1.0 lib32stdc++6 \
  git vim ant sudo android-tools-adb libfontconfig bzip2 wget

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set up USB device debugging (device is ID in the rules files)
COPY 51-android.rules /etc/udev/rules.d/
RUN chmod a+r /etc/udev/rules.d/51-android.rules

WORKDIR /home/ubuntu

RUN curl 'https://storage.googleapis.com/appengine-sdks/featured/appengine-java-sdk-1.9.98.zip' > /tmp/appengine.zip && \
  unzip -d /home/ubuntu /tmp/appengine.zip && \
  rm /tmp/appengine.zip

RUN wget -P /home/ubuntu/pjs 'https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2' && \
  tar xf /home/ubuntu/pjs/phantomjs-2.1.1-linux-x86_64.tar.bz2 -C /home/ubuntu/pjs && \
  rm /home/ubuntu/pjs/phantomjs-2.1.1-linux-x86_64.tar.bz2

EXPOSE 8888 5037

USER ubuntu
ENV OPENSSL_CONF=/etc/ssl \
  PATH=$PATH:/home/ubuntu/pjs/phantomjs-2.1.1-linux-x86_64/bin

WORKDIR /home/ubuntu
