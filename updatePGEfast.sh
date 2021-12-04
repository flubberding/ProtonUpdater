#!/usr/bin/env bash
baseuri="https://github.com/GloriousEggroll/proton-ge-custom/releases/download"
latesturi="https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest"
dstpath="$HOME/.steam/root/compatibilitytools.d"


  latestversion="$(curl -s $latesturi | egrep -m1 "tag_name" | cut -d \" -f4)"
  if [[ -d $dstpath/Proton-$latestversion ]]
  then
    echo "Proton $latestversion is the latest version and is already installed."
    sleep 1
    echo "Exiting..."
    sleep 1
    exit 0
  else
    echo "Proton $latestversion is the latest version and is not installed yet."
    sleep 3
    echo "Installing the latest version of Proton now!"
    sleep 2
    url=$(curl -s $latesturi | egrep -m1 "browser_download_url.*.tar.gz" | cut -d \" -f4)
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
