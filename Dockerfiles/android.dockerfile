FROM ubuntu:jammy

ENV ANDROID_SDK_CMD_TOOLS_VERSION="8092744" FLUTTER_VERSION="2.10.2-stable"
ENV ANDROID_HOME=/opt/android-sdk-linux FLUTTER_SDK=/opt/flutter-sdk
ENV GRADLE_VERSION="7.4.2" GRADLE_HOME=/opt/gradle
ENV PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${FLUTTER_SDK}/flutter/bin:${GRADLE_HOME}/gradle-${GRADLE_VERSION}/bin TZ=Etc/UTC
WORKDIR /opt
RUN apt-get update \
&& DEBIAN_FRONTEND=noninteractive apt-get install -y wget zip unzip bash curl git file xz-utils libglu1-mesa tzdata openjdk-11-jre-headless python3.10 python3-pip \
&& wget -q https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_CMD_TOOLS_VERSION}_latest.zip \   
&& mkdir -p ${ANDROID_HOME}/cmdline-tools/latest \
&& unzip -q commandlinetools-linux-${ANDROID_SDK_CMD_TOOLS_VERSION}_latest.zip -d ${ANDROID_HOME}/cmdline-tools/latest \
&& mv ${ANDROID_HOME}/cmdline-tools/latest/cmdline-tools/* ${ANDROID_HOME}/cmdline-tools/latest \
&& rm -rd ${ANDROID_HOME}/cmdline-tools/latest/cmdline-tools \
&& echo 'yes' | sdkmanager --install "build-tools;32.0.0" "platform-tools" "platforms;android-32" \
&& yes | sdkmanager --licenses \
&& mkdir ${FLUTTER_SDK} \
&& wget -q https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}.tar.xz \
&& tar -xf flutter_linux_${FLUTTER_VERSION}.tar.xz --directory ${FLUTTER_SDK} \
&& mkdir -p ${GRADLE_HOME} \
&& wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
&& unzip -q gradle-${GRADLE_VERSION}-bin.zip -d ${GRADLE_HOME} \
&& chown -R root:root ${FLUTTER_SDK} \
&& rm gradle-${GRADLE_VERSION}-bin.zip flutter_linux_${FLUTTER_VERSION}.tar.xz commandlinetools-linux-${ANDROID_SDK_CMD_TOOLS_VERSION}_latest.zip
# USER bob-the-builder
CMD [ "/usr/bin/bash" ]
    