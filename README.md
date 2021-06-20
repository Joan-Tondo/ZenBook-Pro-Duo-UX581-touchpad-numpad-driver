# Asus touchpad numpad driver

![asus-zenbook-pro-duo-touchpad2](https://user-images.githubusercontent.com/86166007/122673280-f5f76a00-d1cf-11eb-9fec-a646800f3e6b.jpg)


Install required packages

- Debian / Ubuntu / Linux Mint / Pop!_OS / Zorin OS:
```
sudo apt install libevdev2 python3-libevdev i2c-tools git
```

- Arch Linux / Manjaro:
```
sudo pacman -S libevdev python-libevdev i2c-tools git
```

- Fedora:
```
sudo dnf install libevdev python-libevdev i2c-tools git
```

Then enabble i2c
```
sudo modprobe i2c-dev
sudo i2cdetect -l
```

Now you can get the latest ASUS Touchpad Numpad Driver for Linux from Git and install it using the following commands.
```
git clone https://github.com/mohamed-badaoui/asus-touchpad-numpad-driver
cd asus-touchpad-numpad-driver
chmod +x ./install.sh
sudo ./install.sh
```

To turn on/off numpad, tap top right corner touchpad area or F8 key.

To uninstall, just run:
```
sudo ./uninstall.sh
```

It is an adaptation made thanks to:
 - solution published on reddit (https://www.reddit.com/r/linuxhardware/comments/f2vdad/a_service_handling_touchpad_numpad_switching_for/) 
 - many contributions on launchpad (https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1810183)

For any question, please do not hesitate to follow this tread discussion
(https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1810183)

Thank you very much to https://github.com/mohamed-badaoui/asus-touchpad-numpad-driver

