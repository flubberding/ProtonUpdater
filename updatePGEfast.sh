#!/usr/bin/env bash
baseuri="https://github.com/GloriousEggroll/proton-ge-custom/releases/download"
latesturi="https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest"
dstpath="$HOME/.steam/root/compatibilitytools.d"


  latestversion="$(curl -s $latesturi | egrep -m1 "tag_name" | cut -d \" -f4)"
  if [[ -d $dstpath/Proton-$latestversion ]]
  then
    echo "Proton $latestversion is the latest version and is already installed."
    echo "Exiting..."
    exit 0
  else
    echo "Proton $latestversion is the latest version and is not installed yet."
    echo "Installing Proton $latestverion"
    url=$(curl -s $latesturi | egrep -m1 "browser_download_url.*Proton" | cut -d \" -f4)
  fi

rsp="$(curl -sI "$url" | head -1)"
echo "$rsp" | grep -q 302 || {
  echo "$rsp"
  exit 1
}

[ -d "$dstpath" ] || {
    mkdir "$dstpath"
    echo [Info] Created "$dstpath"
}

curl -sL "$url" | tar xfzv - -C "$dstpath"