#!/bin/bash
#
# About: Install Drastic automatically
# Author: liberodark
# Thanks : 
# License: GNU GPLv3

version="0.0.1"

echo "Welcome on Drastic Install Script $version"

# Libs
# libasound2-dev libsdl2-dev zlib1g-dev


download_drastic(){
   echo "Download Drastic"
   wget https://github.com/liberodark/drastic-for-batocera/releases/download/2.4.0.0p/drastic.zip > /dev/null 2>&1
   unzip -Do drastic.zip
   rm -f drastic.zip
}

download_es_systems(){
   echo "Download es_systems"
   wget https://raw.githubusercontent.com/liberodark/drastic-for-batocera/master/es_systems.cfg > /dev/null 2>&1
   if [ -e "/userdata/system/configs/emulationstation/es_systems.cfg" ]; then
   mv /userdata/system/configs/emulationstation/es_systems.cfg /userdata/system/configs/emulationstation/es_systems.cfg.bak
   fi
   mv es_systems.cfg /userdata/system/configs/emulationstation/es_systems.cfg
   rm -f es_systems.cfg
}

install() {
    echo "Install Drastic"
    cd /userdata/ || exit
    download_drastic
    chmod 644 "/userdata/drastic/game_database.xml"
    #chmod +x "/userdata/drastic/drastic"
    mkdir -p "/userdata/roms/nds"
    download_es_systems
    batocera-save-overlay
    /etc/init.d/S31emulationstation restart > /dev/null 2>&1
    echo "Done."
}

install
