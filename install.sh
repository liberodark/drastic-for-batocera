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
   wget https://github.com/liberodark/drastic-for-batocera/releases/download/2.4.0.0p/drastic.tar.gz
}

download_es_systems(){
   echo "Download es_systems"
   wget https://raw.githubusercontent.com/liberodark/drastic-for-batocera/master/es_systems.cfg
}

install() {
    echo "Install Drastic"
    cd /userdata/ || exit
    download_drastic
    tar -xvf drastic.tar.gz
    rm -f drastic.tar.gz
    chmod 644 "/userdata/drastic/game_database.xml"
    mkdir -p "/userdata/roms/nds"
    download_es_systems
    mount -o remount,rw /
    cp -a /usr/share/emulationstation/es_systems.cfg /usr/share/emulationstation/es_systems.cfg.bak
    cp -a es_systems.cfg /usr/share/emulationstation/es_systems.cfg
    mount -o remount,ro /
    batocera-save-overlay
    /etc/init.d/S31emulationstation restart
    echo "Done."
}

install
