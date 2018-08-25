#!/bin/bash
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

apt-get update
apt-get upgrade -y
apt-get -y install software-properties-common
apt-add-repository -y ppa:bitcoin/bitcoin
apt-get update
apt-get -y install wget git unzip libevent-dev libboost-dev libboost-chrono-dev libboost-filesystem-dev libboost-program-options-dev libboost-system-dev libboost-test-dev libboost-thread-dev libminiupnpc-dev build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libzmq3-dev nano libdb4.8-dev libdb4.8++-dev

git clone https://github.com/StakeAddict/Wino
cd Wino
find . -name "*.sh" -exec sudo chmod 755 {} \;
chmod 755 src/leveldb/build_detect_platform
./autogen.sh
./configure --without-gui --disable-tests
make
make install
reboot
