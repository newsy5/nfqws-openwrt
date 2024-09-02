#!/bin/sh

ABSOLUTE_FILENAME=`readlink -f "$0"`
HOME_FOLDER=`dirname "$ABSOLUTE_FILENAME"`
BASE_URL="https://raw.githubusercontent.com/newsy5/nfqws-openwrt/master"

cd /tmp
mkdir -p nfqws-openwrt/common

curl -SL# "$BASE_URL/uninstall.sh" -o "nfqws-openwrt/uninstall.sh"
curl -SL# "$BASE_URL/common/install_func.sh" -o "nfqws-openwrt/common/install_func.sh"

chmod +x ./nfqws-openwrt/*.sh
./nfqws-openwrt/uninstall.sh

rm -rf nfqws-openwrt
cd $HOME_FOLDER

exit 0
