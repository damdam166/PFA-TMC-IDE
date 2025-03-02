FROM ubuntu:20.04

COPY ./tmcl-ide-linux-x64-4.6.0.bin /root/tmcl-ide-linux-x64-4.6.0.bin
RUN chmod +x /root/tmcl-ide-linux-x64-4.6.0.bin

# Geographical area
RUN apt-get update && apt-get install -y \
    locales \
    && rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# It stucks the downloading
ARG DEBIAN_FRONTEND=noninteractive

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

# Add USB access
RUN usermod -aG dialout root

# Tools to debug USB driver D2XX
RUN apt-get update && apt-get install -y \
    kmod \
    usbutils \
    && rm -rf /var/lib/apt/lists/*

# The USB Driver Setup (D2XX)
RUN mkdir -p /root/libftd2xx
COPY ./libftd2xx/libft4222-linux-1.4.4.221.tgz /root/libftd2xx/libftd2xx.tgz
RUN cd /root/libftd2xx && \
    tar -xvzf libftd2xx.tgz && \
    /root/libftd2xx/install4222.sh

# Bash scripts for newbies
RUN echo '#!/bin/bash\nexec /root/tmcl-ide-linux-x64-4.6.0.bin "$@"' > /usr/local/bin/setup && \
    chmod +x /usr/local/bin/setup

RUN echo '#!/bin/bash\nexec /root/ADI-Trinamic-Tools/TMCL-IDE/V4.6.0/TMCL-IDE.sh "$@"' > /usr/local/bin/ide && \
    chmod +x /usr/local/bin/ide

# Some commands to simplify debug
WORKDIR /root
CMD ["/bin/bash"]

