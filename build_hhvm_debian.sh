#!/bin/bash

# install packages

sudo apt-get install git-core automake cmake libmysqlclient-dev \
  libxslt1.1 libxml2-dev libmcrypt-dev libicu-dev openssl build-essential binutils-dev \
  libcap-dev zlib1g-dev libtbb-dev libonig-dev libpcre3-dev \
  autoconf libtool libcurl4-openssl-dev wget memcached \
  libreadline-dev libncurses-dev libmemcached-dev libbz2-dev \
  libc-client2007e-dev php5-mcrypt php5-imagick libgoogle-perftools-dev \
  libcloog-ppl0 libelf-dev libdwarf-dev libunwind7-dev subversion \
  libtbb2 libtbb-dev g++-4.7 gcc-4.7 libjemalloc-dev \
  libc6-dev libmpfr4 libgcc1 binutils \
  libc6 libc-dev-bin libc-bin libgomp1 \
  libstdc++6-4.7-dev libstdc++6 cmake \
  libarchive12 cmake-data libacl1 libattr1 \
  g++ cpp gcc make libboost-thread1.49.0 \
  libboost-thread-dev libgd2-xpm-dev \
  pkg-config libdwarf-dev binutils-dev libboost-system1.49-dev \
  libboost-program-options1.49-dev libboost-filesystem1.49-dev libboost-regex1.49-dev \
  libmagickwand-dev libxslt1-dev

#  Getting HipHop source-code
mkdir dev
cd dev
git clone git://github.com/facebook/hhvm.git
export CMAKE_PREFIX_PATH=`pwd`
cd hhvm
git submodule init
cd ..

#  libevent (Optional if you want builtin web-server support)

git clone git://github.com/libevent/libevent.git
cd libevent
git checkout release-1.4.14b-stable
cat ../hhvm/hphp/third_party/libevent-1.4.14.fb-changes.diff | patch -p1
./autogen.sh
./configure --prefix=$CMAKE_PREFIX_PATH
make
make install
cd ..

#  Google glog

svn checkout http://google-glog.googlecode.com/svn/trunk/ google-glog
cd google-glog
./configure --prefix=$CMAKE_PREFIX_PATH
make
make install
cd ..

#   Building HipHop

cd hhvm
git submodule update
export HPHP_HOME=`pwd`
cmake .
make
