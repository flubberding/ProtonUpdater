#!/usr/bin/env bash
latesturi="https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest"
dstpath="$HOME/.steam/root/compatibilitytools.d"

url="$(curl -s $latesturi | egrep -m1 "browser_download_url.*Proton.*.tar.gz" | cut -d \" -f4)"
latestversion="$(echo $url | cut -d / -f9 | cut -d . -f1)"
if [[ -d $dstpath/$latestversion ]]
then
  echo "Proton $latestversion is the latest version and is already installed."
  echo "Exiting..."
  exit 0
else
  echo "Proton $latestversion is the latest version and is not installed yet."
  echo "Installing Proton $latestverion"
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
