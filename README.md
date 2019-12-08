# CProton - Custom Proton Installationscript
Script to make it easier to update Proton GE to the latest version.

Two simple scripts to help you to install the latest version of GloriousEggroll's custom Proton, which can be found [here](https://github.com/GloriousEggroll/proton-ge-custom)


[Original script by /u/ChockFullOfShit](https://www.reddit.com/r/SteamPlay/comments/e2ms5v/custom_proton_glorious_eggroll_proton420ge1/f8y2ioe/), I (/u/flubberding) expanded a bit on it.

Disclaimer: Subversions like the MCC versions of Proton 4.21-GE-1, will install as it's main version and not install separately.
For now, this may result in false "not installed"-detections or errors while force installing a specific subversion.

There are two scripts:
#### [cproton.sh](cproton.sh)

This is the full script. when you run it without any arguments, it checks for the latest Proton GE version and checks if it's a;ready installed. After this you it promps you with the question if you want to (re)install it.
You can also run this script with a specific Proton GE version as argument to downlaod and install this specific version (i.e. ./getProtonGE 4.15-GE-1).
Use **-l** as an argument to get a list of releases. You can use this list to download specific versions.

##### Options
You can set some options in this script. Open the script in a text editor to do so.
```
 Set restartSteam=0 to not restart steam after installing Proton (Keep process untouched)
 Set restartSteam=1 to autorestart steam after installing Proton
 Set restartSteam=2 to to get a y/n prompt asking if you want to restart Steam after each installation.
 
 Set autoInstall=true to skip the installation prompt and install the latest not-installed, or any forced Proton GE builds
 Set autoInstall=false to display a installation-confirmation prompt when installing a Proton GE build
```

#### [updatePGEfast.sh](updatePGEfast.sh)

This is a simplified version of the script, made to be a bit quicker. It skips the question-prompt and installs the latest version of Proton GE if it's not installed.
