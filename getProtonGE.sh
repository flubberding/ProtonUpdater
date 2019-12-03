#!/usr/bin/env bash
baseuri="https://github.com/GloriousEggroll/proton-ge-custom/releases/download"
latesturi="https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases/latest"
dstpath="$HOME/.steam/root/compatibilitytools.d"

ge_ver="${1}"
if [ -z "$ge_ver" ]
then
  latestversion="$(curl -s $latesturi | egrep -m1 "tag_name" | cut -d \" -f4)"
  if [[ -d $dstpath/Proton-$latestversion ]]
  then
    echo "Proton $latestversion is the latest version and is already installed."
  else
    echo "Proton $latestversion is the latest version and is not installed yet."
  fi

  read -p "Do you want to download and (re)install this release? <y/N> " prompt
    if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
    then
      url=$(curl -s $latesturi | egrep -m1 "browser_download_url.*Proton" | cut -d \" -f4)
    else
      echo "Operation canceled"
      exit 0
    fi
elif [ $ge_ver == "-l" ]
then
  curl -s https://api.github.com/repos/GloriousEggroll/proton-ge-custom/releases  | grep -H "tag_name" | cut -d \" -f4
else
  if [[ -d $dstpath/Proton-$ge_ver ]]
  then
    echo "Proton $ge_ver is already installed."
  else
    echo "Proton $ge_ver is not installed yet."
  fi

  read -p "Do you want to try to download and (re)install this release? <y/N> " prompt
    if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
    then
      url=$baseuri/"$ge_ver"/Proton-"$ge_ver".tar.gz
    else
      echo "Operation canceled"
      exit 0
    fi
fi

if [ $ge_ver != "-l" ]
then
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
fi
