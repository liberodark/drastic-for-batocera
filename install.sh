#!/bin/bash
#
# About: Install Eka2l1 automatically
# Author: soaresden
# Thanks : 
# License: GNU GPLv3

version="1.0"

echo "Welcome on Eka2l1 Install Script $version"

# Libs
# libasound2-dev libsdl2-dev zlib1g-dev


download_eka2l1(){
   echo "Download Eka2l1"
   wget https://github.com/EKA2L1/EKA2L1/releases/download/continous/ubuntu-latest.zip > /dev/null 2>&1
   unzip -Do ubuntu-latest.zip
   rm -f ubuntu-latest.zip
}

download_es_systems(){
   echo "Download es_systems"
   wget https://raw.githubusercontent.com/soaresden/drastic-for-batocera/master/es_systems.cfg > /dev/null 2>&1
   if [ -e "/userdata/system/configs/emulationstation/es_systems.cfg" ]; then
   mv /userdata/system/configs/emulationstation/es_systems.cfg /userdata/system/configs/emulationstation/es_systems.cfg.bak
   fi
   mv es_systems.cfg /userdata/system/configs/emulationstation/es_systems.cfg
   rm -f es_systems.cfg
}

install() {
    echo "Install Eka2l1"
    cd /userdata/ || exit
    download_eka2l1
    chmod 644 "/userdata/eka2l1/game_database.xml"
    #chmod +x "/userdata/eka2l1/eka2l1"
    mkdir -p "/userdata/roms/n-gage"
    download_es_systems
    batocera-save-overlay
    /etc/init.d/S31emulationstation restart > /dev/null 2>&1
    echo "Done."
}

install
