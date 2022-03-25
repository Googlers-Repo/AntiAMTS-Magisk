#!/bin/sh

# This gets not executed by Magisk

buildLinux() {
    exec gcc build/amts-server.c -o system/bin/amts-server
}

buildAndroid() {
    exec aarch64-linux-gnu-gcc build/amts-server.c -o system/bin/amts-server -static
}

while getopts "al" opt
do
   case "$opt" in
      a ) buildAndroid ;;
      l ) buildLinux ;;
   esac
done