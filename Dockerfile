FROM ubuntu:22.04

COPY ./tmcl-ide-linux-x64-4.6.0.bin /root/tmcl-ide-linux-x64-4.6.0.bin
RUN chmod +x /root/tmcl-ide-linux-x64-4.6.0.bin

# Setup executable
RUN apt-get update && apt-get install -y \
    build-essential \
    libx11-xcb1 \
    libxcb-icccm4 \
    libxcb-xinerama0 \
    libxcb-randr0 \
    libxcb-shape0 \
    libxcb-keysyms1 \
    libxcb-cursor0 \
    libfreetype6 \
    libfontconfig1 \
    libxrender1 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxi6 \
    libxtst6 \
    libglib2.0-0 \
    libgtk2.0-0 \
    libnss3 \
    libdbus-1-3 \
    libxrandr2 \
    libxext6 \
    libx11-6 \
    libxcb1 \
    libxss1 \
    libasound2 \
    libxkbcommon-x11-0 \
    libxcb-sync1 \
    libxcb-xfixes0 \
    libxcb-xkb1 \
    libxkbcommon0 \
    locales \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Geographical area
ARG DEBIAN_FRONTEND=noninteractive

# Qt and OpenGL
RUN apt-get update && apt-get install -y \
    qtbase5-dev \
    qttools5-dev-tools \
    qttools5-dev \
    libqt5svg5 \
    libqt5printsupport5 \
    libqt5charts5-dev \
    libqt5serialport5-dev \
    libqt5serialbus5-dev \
    libqt5xml5 \
    libqt5gui5 \
    libqt5network5 \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Qt using X11
ENV QT_QPA_PLATFORM=xcb

# Bash scripts for newbies
RUN echo '#!/bin/bash\nexec /root/tmcl-ide-linux-x64-4.6.0.bin "$@"' > /usr/local/bin/setup && \
    chmod +x /usr/local/bin/setup

RUN echo '#!/bin/bash\nexec /root/ADI-Trinamic-Tools/TMCL-IDE/V4.6.0/TMCL-IDE.sh "$@"' > /usr/local/bin/ide && \
    chmod +x /usr/local/bin/ide

# Add USB access
RUN usermod -aG dialout root

# USB driver D2XX
RUN apt-get update && apt-get install -y \
    kmod \
    usbutils \
    && rm -rf /var/lib/apt/lists/*

# Driver for x86_64
COPY ./libftd2xx-x86_64-1.4.27.tgz /root/libftd2xx-x86_64-1.4.27.tgz
RUN tar -C /root/ -xvzf /root/libftd2xx-x86_64-1.4.27.tgz
RUN rmmod ftdi_sio || true && rmmod usbserial || true && modprobe -r ftdi_sio || true
RUN cd /root/release/build && cp libftd2xx.* /usr/local/lib
RUN chmod 0755 /usr/local/lib/libftd2xx.so.1.4.27
RUN ln -sf /usr/local/lib/libftd2xx.so.1.4.27 /usr/local/lib/libftd2xx.so
RUN cd /root/release && cp ftd2xx.h  /usr/local/include && cp WinTypes.h  /usr/local/include
RUN ldconfig -v

WORKDIR /root
CMD ["/bin/bash"]

