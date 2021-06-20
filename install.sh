#!/bin/bash

# -------------------------------------------------------
# A shell script that install python driver for Asus numpad 
# MIT LICENSE file
# Written by: Joan Tondo
# Last updated on: 2021/06/20
# -------------------------------------------------------

# Checking if the script is runned as root (via sudo or other)
if [[ $(id -u) != 0 ]]
then
	echo "Please run the installation script as root (using sudo for example)"
	exit 1
fi

modprobe i2c-dev

# Checking if the i2c-dev module is successfuly loaded
if [[ $? != 0 ]]
then
	echo "i2c-dev module cannot be loaded correctly. Make sur you have installed i2c-tools package"
	exit 1
fi

interfaces=$(for i in $(i2cdetect -l | grep DesignWare | sed -r "s/^(i2c\-[0-9]+).*/\1/"); do echo $i; done)
if [ -z "$interfaces" ]
then
    echo "No interface i2c found. Make sure you have installed libevdev packages"
    exit 1
fi

touchpad_detected=false;
for i in $interfaces; do
    echo -n "Testing interface $i : ";
    number=$(echo -n $i | cut -d'-' -f2)
	offTouchpadCmd="i2ctransfer -f -y $number w13@0x15 0x05 0x00 0x3d 0x03 0x06 0x00 0x07 0x00 0x0d 0x14 0x03 0x00 0xad"
    i2c_test=$($offTouchpadCmd 2>&1)
    if [ -z "$i2c_test" ]
    then
        echo "sucess"
        touchpad_detected=true;
        break
    else
        echo "failed"
    fi
done;

if [ "$touchpad_detected" = false ] ; then
    echo 'The detection was not successful. Touchpad not found.'
    exit 1
fi

echo "Copy asus python driver to /usr/bin/asus_touchpad_numpad.py"
cp touchpad_numpad_symbols.py /usr/bin/asus_touchpad_numpad.py


echo "Add asus touchpad service in /lib/systemd/system/"
cp ./asus_touchpad_numpad.service /lib/systemd/system/
echo "i2c-dev" | tee /etc/modules-load.d/i2c-dev.conf >/dev/null

systemctl enable asus_touchpad_numpad

if [[ $? != 0 ]]
then
	echo "Something gone wrong while enabling asus_touchpad_numpad.service"
	exit 1
else
	echo "Asus touchpad service enabled"
fi

systemctl restart asus_touchpad_numpad
if [[ $? != 0 ]]
then
	echo "Something gone wrong while enabling asus_touchpad_numpad.service"
	exit 1
else
	echo "Asus touchpad service started"
fi

exit 0

