#!/usr/bin/env bash
baseuri="https://github.com/GloriousEggroll/proton-ge-custom/releases/download"
latesturi="https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest"
parameter="${1}"
installComplete=false;
dstpath="$HOME/.steam/root/compatibilitytools.d" #### Destinationforlder of the Proton installations
restartSteam=2
autoInstall=false
#### Set restartSteam=0 to not restart steam after installing Proton (Keep process untouched)
#### Set restartSteam=1 to autorestart steam after installing Proton
#### Set restartSteam=2 to to get a y/n prompt asking if you want to restart Steam after each installation.

#### Set autoInstall=true to skip the installation prompt and install the latest not-installed, or any forced Proton GE builds
#### Set autoInstall=false to display a installation-confirmation prompt when installing a Proton GE build

# ########################################## CProton - Custom Proton Installscript 0.2.2 ##########################################
# Disclaimer: Subversions like the MCC versions of Proton 4.21-GE-1, will install as it's main version and not install separately.
# For now, this may result in false "not installed"-detections or errors while force installing a specific subversion.

PrintReleases() {
  echo "----------Description----------"
  echo ""
  echo "Run './cproton.sh [VersionName]'"
  echo "to download specific versions."
  echo ""
  echo "------------Releases------------"
  curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases | grep -H "tag_name" | cut -d \" -f4
  echo "--------------------------------"
}

InstallProtonGE() {
  rsp="$(curl -sI "$url" | head -1)"
  echo "$rsp" | grep -q 302 || {
    echo "$rsp"
    exit 1
  }

  [ -d "$dstpath" ] || {
    mkdir "$dstpath"
    echo [Info] Created "$dstpath"
  }
  curl -sL "$url" > $dstpath/Proton-"$version".tar.gz # Download archive first
  if [ ! -z "$sha512url" ]; then # If there is no sha512 the sha512url is empty 
	if [ $(sha512sum $dstpath/Proton-"$version".tar.gz | cut -b -128) == $((curl -sL $sha512url)| cut -b -128) ]; then # Only the first 128 bytes are significant
	  tar xfzv $dstpath/Proton-"$version".tar.gz -C "$dstpath"
  	  installComplete=true
	else
	  echo "sha512sum did not match! Stopping installation."
	  installComplete=false
	fi
  else
    tar xfzv $dstpath/Proton-"$version".tar.gz -C "$dstpath"
  	installComplete=true
  fi
  rm $dstpath/Proton-"$version".tar.gz
}

RestartSteam() {
  if [ "$( pgrep steam )" != "" ]; then
    echo "Restarting Steam"
    pkill -TERM steam #restarting Steam
    sleep 5s
    nohup steam </dev/null &>/dev/null &
  fi
}

RestartSteamCheck() {
  if [ "$( pgrep steam )" != "" ] && [ "$installComplete" = true ]; then
    if [ $restartSteam == 2 ]; then
      read -r -p "Do you want to restart Steam? <y/N> " prompt
      if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]; then
        RestartSteam
      else
        exit 2
      fi
    elif [ $restartSteam == 0 ]; then
      exit 0
    fi
    RestartSteam
  fi
}

InstallationPrompt() {
  if [ "$autoInstall" = true ]; then
    if [ ! -d "$dstpath"/Proton-"$version" ]; then
      InstallProtonGE
    fi
  else
    read -r -p "Do you want to try to download and (re)install this release? <y/N> " prompt
    if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]; then
      InstallProtonGE
    else
      echo "Operation canceled"
      exit 0
    fi
  fi
}

if [ -z "$parameter" ]; then
  version="$(curl -s $latesturi | grep -E -m1 "tag_name" | cut -d \" -f4)"
  url=$(curl -s $latesturi | grep -E -m1 "browser_download_url.*.tar.gz" | cut -d \" -f4)
  sha512url=$(curl -s $latesturi | grep -E -m1 "browser_download_url.*.sha512sum" | cut -d \" -f4)
  if [ -d "$dstpath"/Proton-"$version" ]; then
    echo "Proton $version is the latest version and is already installed."
  else
    echo "Proton $version is the latest version and is not installed yet."
  fi
elif [ "$parameter" == "-l" ]; then
  PrintReleases
else
  url=$baseuri/"$parameter"/Proton-"$parameter".tar.gz
  if [ -d "$dstpath"/Proton-"$parameter" ]; then
    echo "Proton $parameter is already installed."
  else
    echo "Proton $parameter is not installed yet."
  fi
fi

if [ ! "$parameter" == "-l" ]; then
  InstallationPrompt
  RestartSteamCheck
fi
