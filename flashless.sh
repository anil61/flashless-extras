#!/bin/bash
#Title: Flashless Restricted Extras Installer for Ubuntu
#Description: Installs patent encumbered audio and video codecs
#Author: Quidsup
#Date: 24 Apr 2016
#Usage: bash flashless-extras.sh

if [ "$(command -v apt)" ]; then       #Is this an Ubuntu / Debian based distro?
  #Ask user whether they want to install Microsoft fonts
  echo -n "Do you want to install Microsoft TrueType Fonts (y/n)? "
  read -rn1 Fonts  
  echo
  
  echo "Updating repositories"
  sudo apt update
  echo 
  
  if [[ $(pgrep kwin) != "" ]]; then   #Different set of packages are needed for KDE based systems
    echo "Installing Restricted Extras for KDE based system"
    sudo apt install -y lame unrar gstreamer1.0-fluendo-mp3 gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-fluendo-mp3 libdvdread4 libk3b6-extracodecs  oxideqt-codecs-extra libavcodec-extra libavcodec-ffmpeg-extra56 libk3b6-extracodecs
  else
    echo "Installing Restricted Extras"
    sudo apt install -y lame unrar gstreamer1.0-fluendo-mp3 gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-fluendo-mp3 libdvdread4 libk3b6-extracodecs  oxideqt-codecs-extra libavcodec-extra libavcodec-ffmpeg-extra56
  fi
  
  #Optional install of Microsoft fonts
  if [[ $Fonts == "y" ]] || [[ $Fonts == "Y" ]]; then
    echo "Installing Microsoft Fonts"
    sudo apt install -y ttf-mscorefonts-installer
  fi

elif [ "$(command -v pacman)" ];then    #Installing restricted extras for Arch based systems
  echo -n "Do you want to install Microsoft TrueType Fonts (y/n)?"
  read -rn1 Fonts
  echo

  echo "Updating repositories"
  sudo pacman -Syyy
  echo

  if [[ $(pgrep kwin) != "" ]];then     #Different set of packages are needed for KDE based systems
     echo "Installing Restricted Extras for KDE based system"
     sudo pacman --no-confirm -Sy lame unrar gstreamer gst-plugins-bad gst-plugins-ugly gst-libav libdvdread libdvdcss k3b ffmpeg ffmpeg2.8
     yaourt -Sy gst-fluendo-mp3
  else
     echo "Installing Restricted Extras"
     sudo pacman --no-confirm -Sy lame unrar gstreamer gst-plugins-bad gst-plugins-ugly gst-libav libdvdread libdvdcss ffmpeg ffmpeg2.8
     yaourt -Sy gst-fluendo-mp3
  fi

  #Optional install of Microsoft fonts
  if [[ $Fonts == "y" ]] || [[ $Fonts == "Y" ]];then
     echo "Installing Microsoft Fonts"
     yaourt --no-confirm -Sy ttf-ms-fonts
  fi
else                               #Throw error for non Deb systems
  echo "Sorry, the Flashless Extras script has only been written for Debian and Arch based systems."
  exit 1
fi

echo
#DVD CSS Decoder install varies between pre 15.04 and 15.10 onwards
#DVD CSS Decoder installation and configuration is done more "automatically" on Arch based systems. The following stuf is for Debian based systems only
if [ -e /usr/share/doc/libdvdread4/install-css.sh ]; then
  echo "Installing DVD CSS Decoder"
  sudo /usr/share/doc/libdvdread4/install-css.sh
else
  echo "To install DVD CSS Decoder run: sudo apt install libdvd-pkg"
fi

echo
echo "Flashless extras script complete :)"
echo
