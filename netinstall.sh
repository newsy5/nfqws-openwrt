#!/bin/sh

ABSOLUTE_FILENAME=`readlink -f "$0"`
HOME_FOLDER=`dirname "$ABSOLUTE_FILENAME"`
BASE_URL="https://raw.githubusercontent.com/newsy5/nfqws-openwrt/master"

cd /tmp
mkdir -p nfqws-openwrt/etc/nfqws
mkdir -p nfqws-openwrt/etc/init.d
mkdir -p nfqws-openwrt/etc/ndm/netfilter.d
mkdir -p nfqws-openwrt/common

curl -SL# "$BASE_URL/install.sh" -o "nfqws-openwrt/install.sh"
curl -SL# "$BASE_URL/common/install_func.sh" -o "nfqws-openwrt/common/install_func.sh"
curl -SL# "$BASE_URL/etc/nfqws/nfqws.conf" -o "nfqws-openwrtc/etc/nfqws/nfqws.conf"
curl -SL# "$BASE_URL/etc/nfqws/user.list" -o "nfqws-openwrt/etc/nfqws/user.list"
curl -SL# "$BASE_URL/etc/nfqws/auto.list" -o "nfqws-openwrt/etc/nfqws/auto.list"
curl -SL# "$BASE_URL/etc/nfqws/exclude.list" -o "nfqws-openwrt/etc/nfqws/exclude.list"
curl -SL# "$BASE_URL/etc/init.d/S51nfqws" -o "nfqws-openwrt/etc/init.d/S51nfqws"
#curl -SL# "$BASE_URL/etc/ndm/netfilter.d/100-nfqws.sh" -o "nfqws-openwrt/etc/ndm/netfilter.d/100-nfqws.sh"

chmod +x ./nfqws-openwrt/*.sh
./nfqws-openwrt/install.sh

rm -rf nfqws-openwrt
cd $HOME_FOLDER

exit 0
