# How to install TMC-IDE

This installation guide is tested on `Arch, Linux 6.12 lts`.

You might need to install a driver to use *USB-2-RTMI*, go watch the links.

## First version - Common Way

``` shell
unzip tmcl-ide-linux-x64-4.6.0.zip
chmod +x tmcl-ide-linux-x64-4.6.0.bin
./tmcl-ide-linux-x64-4.6.0.bin
./ADI-Trinamic-Tools/TMCL-IDE/V4.6.0/TMCL-IDE.sh
```

If the *USB* device is not recognized, you might need to install the driver.
Go watch the links.

&#x2705; Easy.

&#x274C; Install weird things on your computer.

## Second version - Cool Way

``` shell
unzip tmcl-ide-linux-x64-4.6.0.zip
docker build -t tmc-ide .

% Common way :
xhost +local:
% For last last last Ubuntu version :
xhost +SI:localuser:root

% `--device=/dev/bus/usb:/dev/bus/usb` mounts all USB ports.
% Is it better to use `--privileged` here ? idk
docker run -dit --name ide -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --device=/dev/bus/usb:/dev/bus/usb tmc-ide
docker exec -it ide setup
docker exec -it ide ide
```

&#x2705; Does not depend on the distro.

&#x274C; Hard.

&#x274C; If it is not working, just don't try to understand why.

### How to install xhost

- **Debian**
`apt-get install x11-xserver-utils`

- **Ubuntu**
`apt-get install x11-xserver-utils`

- **Arch Linux**
`pacman -S xorg-xhost`

- **Kali Linux**
`apt-get install x11-xserver-utils`

- **CentOS**
`yum install xorg-x11-server-utils`

- **Fedora**
`dnf install xorg-x11-server-utils`

- **Windows (WSL2)**
`sudo apt-get update sudo apt-get install x11-xserver-utils`

- **Raspbian**
`apt-get install x11-xserver-utils`

### How to install Docker

- **Ubuntu** and **Debian**
`curl -fsSL https://get.docker.com | sh`

- **Arch Linux** and **Manjaro**
`sudo pacman -Sy --noconfirm docker && sudo systemctl enable --now docker`

- **Fedora**
`sudo dnf install -y docker docker-compose && sudo systemctl enable --now docker`

- **CentOS** and **RHEL**
`sudo yum install -y docker && sudo systemctl enable --now docker`

-  **OpenSUSE**
`sudo zypper install -y docker && sudo systemctl enable --now docker`

- **WSL2** on **Windows**
Use *Docker Desktop* with [this link](https://www.docker.com/products/docker-desktop/).
Then use
`sudo service docker start`

### Useful links

- [TMC4671 Official Page](https://www.analog.com/en/products/tmc4671.html)

- [TMC4671 PI Tuning](https://tmc-item.chiplinkstech.com/AN053_TMC4671-PI_Tuning.pdf)

- [TMC4671 and TMC6100 BOB](https://www.analog.com/en/resources/evaluation-hardware-and-software/evaluation-boards-kits/tmc4671-tmc6100-bob.html#eb-overview)

- [TMC6100 BOB](https://www.analog.com/media/en/technical-documentation/data-sheets/TMC6100_datasheet_rev1.03.pdf)

- [TMC-IDE Installation Official Guide](https://www.analog.com/media/en/technical-documentation/user-guides/how-to-start-linux-tmcl-ide.pdf)

- [USB-2-RTMI Driver Installation](https://www.analog.com/media/en/technical-documentation/user-guides/USB-2-RTMI_hardware_manual_hw2.0_rev2.01.pdf)

### EOF

