# ProtonUpdater
Script to make it easier to update Proton GE to the latest version 

Two simple scripts to help you to install the latest version of GloriousEggroll's custom Proton, which can be found here:
https://github.com/GloriousEggroll/proton-ge-custom

[Original script by /u/ChockFullOfShit](https://www.reddit.com/r/SteamPlay/comments/e2ms5v/custom_proton_glorious_eggroll_proton420ge1/f8y2ioe/), I (/u/flubberding) expanded a bit on it.

There are two scripts:
#### [getProtonGE.sh](getProtonGE.sh)

This is the full script. when you run it without any arguments, it checks for the latest Proton GE version and checks if it's a;ready installed. After this you it promps you with the question if you want to (re)install it.
You can also run this script with a specific Proton GE version as argument to downlaod and install this specific version (i.e. ./getProtonGE 4.15-GE-1).

##### [updatePGEfast.sh](updatePGEfast.sh)

This is a simplified version of the script, made to be a bit quicker. It skips the question-prompt and installs the latest version of Proton GE if it's not installed.
