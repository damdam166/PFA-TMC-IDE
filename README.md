# How to install TMCL-IDE

This installation guide is tested on `Arch, Linux 6.12 lts`.

This installation guide works only on :

- Windows 10 and more.
- Linux using **x86_64** and **x86_32** cpu.
- Linux using **ARM** cpu, except *soft float*.

## Windows User

Follow these steps :

1) Install *TMCL IDE* using [this link](https://www.analog.com/en/resources/evaluation-hardware-and-software/motor-motion-control-software/tmcl-ide.html#latest).

Or you can juste use the binary in the folder `windows_setup/` of this repository.

2) Install the driver using [this link](https://www.analog.com/media/en/technical-documentation/user-guides/USB-2-RTMI_hardware_manual_hw2.0_rev2.01.pdf).

Or you can juste use the binary in the folder `windows_setup/` of this repository.

3) Follow the steps of [this link](https://www.analog.com/media/en/technical-documentation/user-guides/USB-2-RTMI_hardware_manual_hw2.0_rev2.01.pdf).

&#x2705; Easy.

&#x274C; Only working on Windows.

## Linux User

You will need `docker`, see explanation below.

To install the ide and the driver :

```
cd PFA-TMC-IDE

unzip tmcl-ide-linux-x64-4.6.0.zip

% Install xhost if you doesn't have it, see explanation below.
xhost +local:

make install
```

You should connect first the **USB-2-RTMI**, then restart the ide by using :

```
CTRL-C
make
```

When you want to start the ide, use :

```
make
```

If you want to edit some variable names :

```
make clean
SUDO=" " DOCKER_IMAGE="image_name" CONTAINER_NAME="cont_name" make install
```

However, you'll have to manually remove container and image.

&#x2705; Does not depend on the distro.

&#x274C; Hard.

&#x274C; If it is not working, just don't try to understand why.

### A manual Installation on Linux

The file `tmcl-ide-linux-x64-4.6.0.zip` contains the setup executable.

Moreover, you will need to install the driver manually 
by reading the doc in the `libftd2xx/*.tgz`.

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

