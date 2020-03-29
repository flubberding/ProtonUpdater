#!/usr/bin/env bash
baseuri_ge="https://github.com/GloriousEggroll/proton-ge-custom/releases/download"
latesturi_ge="https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest"
baseuri_tkg="https://github.com/Frogging-Family/wine-tkg-git/releases/download"
latesturi_tkg="https://api.github.com/repos/Frogging-Family/wine-tkg-git/releases/latest"
dstpath="$HOME/.steam/root/compatibilitytools.d"

### Install latest version of proton-ge ###

  latestversion_ge="$(curl -s $latesturi_ge | egrep -m1 "tag_name" | cut -d \" -f4)"
  if [[ -d $dstpath/Proton-$latestversion_ge ]]
  then
    echo "Proton $latestversion is the latest version and is already installed."
    echo "Exiting..."
    exit 0
  else
    echo "Proton $latestversion_ge is the latest version of Proton-GE and is not installed yet."
    echo "Installing Proton $latestversion_ge"
    url_ge=$(curl -s $latesturi_ge | egrep -m1 "browser_download_url.*Proton" | cut -d \" -f4)
  fi

rsp_ge="$(curl -sI "$url_ge" | head -1)"
echo "$rsp_ge" | grep -q 302 || {
  echo "$rsp_ge"
  exit 1
}

[ -d "$dstpath" ] || {
    mkdir "$dstpath"
    echo [Info] Created "$dstpath"
}

curl -sL "$url_ge" | tar xfzv - -C "$dstpath"

### Install latest version of proton-tkg ###
  latestversion_tkg="$(curl -s $latesturi_tkg | egrep -m1 "tag_name" | cut -d \" -f4)"
  if [[ -d $dstpath/Proton-TKG-$latestversion_tkg ]]
  then
    echo "Proton $latestversion_tkg is the latest version of Proton-TKG and is already installed."
    echo "Exiting..."
    exit 0
  else
    echo "Proton $latestversion_tkg is the latest version of Proton-TKG and is not installed yet."
    echo "Installing Proton $latestversion_tkg"
    url_tkg=$(curl -s $latesturi_tkg | egrep -m1 "browser_download_url.*proton" | cut -d \" -f4)
  fi


rsp_tkg="$(curl -sI "$url_tkg" | head -1)"
echo "$rsp_tkg" | grep -q 302 || {
  echo "$rsp_tkg"
  exit 1
	}

[ -d "$dstpath" ] || {
    mkdir "$dstpath"
    echo [Info] Created "$dstpath"
	}

#creates a directory for Proton-TKG to be exctracted to, since the .zip-releases of Tk-Glitch don't include such a directory
mkdir "$HOME/.steam/root/compatibilitytools.d/Proton-TKG-$latestversion_tkg"

#downloads and extracts the lastest release of Proton-TKG. Has be to be done differently since Proton-TKG is packaged as a .zip instead of tar.gz
wget -q --show-progress "$url_tkg" -O "Proton-TKG-$latestversion_tkg" && unzip -C "Proton-TKG-$latestversion_tkg" -d "$HOME/.steam/root/compatibilitytools.d/Proton-TKG-$latestversion_tkg" && rm "Proton-TKG-$latestversion_tkg"
