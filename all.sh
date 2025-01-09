#!/bin/bash

DIR=$(dirname $BASH_SOURCE)

if [[ -n "${WSL_DISTRO_NAME}" ]]; then
   if [[ -d "/mnt/wsl/${WSL_DISTRO_NAME}" ]]; then
       : || ls "/mnt/wsl/${WSL_DISTRO_NAME}"
   else 
      mkdir "/mnt/wsl/${WSL_DISTRO_NAME}"
      # note the terminating / on the directory name below!
      wsl.exe -d ${WSL_DISTRO_NAME} -u root mount --bind / "/mnt/wsl/${WSL_DISTRO_NAME}/"
   fi
fi

source "$DIR/alias.sh"
source "$DIR/exports.sh"
source "$DIR/functions.sh"

