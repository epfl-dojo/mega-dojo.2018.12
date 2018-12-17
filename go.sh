#!/bin/bash
# This uses nodemcu-uploader (https://github.com/kmpm/nodemcu-uploader/blob/master/doc/USAGE.md)
# for doing basic operations on the microcontroller. 
# It is installed with pip on a dedicated virtualenv called nodemcu

export PYENV_VERSION=nodemcu

SERIALPORT=$(ls /dev/tty.wchu* | tail -n 1)
if [ -z "$SERIALPORT" ] ; then
  echo "Could not find device port"
  exit
fi

# nodempcu-uploader version
CMD="nodemcu-uploader --port $SERIALPORT --baud=115200"

usage() {
  cat << __EOF | sed 's/^    //'
    Short cut for using nodemcu-uploader. Usage:
    ./go.sh command arguments
    available commands:
      upload     upload files given as arguments to microcontroller
      download   download files given as arguments from microcontroller
      rm         remove  files given as arguments from microcontroller
      ls         list files in microcontroller
      cat        show conten of files given as arguments
      run        execute lua script given as argument
      format     format microcontroller filesystem
      restart    restart microcontroller
      heap       return free memory on microcontroller
__EOF
}


goconsole() {
  echo "Using device $SERIALPORT. Remember to exit: Ctrl-A k"
  sleep 2
  screen $SERIALPORT 115200
}

goupload() {
  $CMD upload --verify=raw $f
}

godownload() {
  $CMD download --verify=raw $f 
}

gols() {
  $CMD file list
}

gorm() {
  $CMD file remove $*
}

gorun() {
  for f in $* ; do 
    $CMD file do $f
  done
}

gocat() {
  for f in $* ; do
    echo "-------------------- content of $f:" 
    $CMD file print $f
  done
}

goheap() {
  $CMD node heap
}

gorestart() {
  $CMD node restart
}

gpformat() {
  $CMD file format
}


cmd=$1
shift 1

if [ "$cmd" == "-h" ] ; then
  usage
else
  go$cmd $*
fi