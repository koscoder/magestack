#!/bin/bash

# Intallation magento from Git repository
# git://github.com/speedupmate/Magento-CE-Mirror.git
#

if [ $# -ne 4 ]
then
    echo "Usage: install.sh -d dirname -v version"
    exit 1
fi

dir=  ver= 

while getopts d:v: opt; do
  case $opt in
  d)
      dir=$OPTARG
      ;;
  v)
      ver=$OPTARG
      ;;
  esac
done

shift $((OPTIND - 1))

mkdir $dir 
git clone git://github.com/speedupmate/Magento-CE-Mirror.git "$dir"
cd $dir
git fetch --tags
git checkout magento-ce-"$ver"
