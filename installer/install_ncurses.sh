#!/bin/sh
#
########################################################################
# Install ncurses
#  $1 = version
#  $2 = not save to src
#
#  Maintainer: id774 <idnanashi@gmail.com>
#
#  v1.3 9/16,2010
#       Refactoring.
#  v1.2 3/7,2010
#       Refactoring.
#  v1.0 8/15,2008
#       Stable.
########################################################################

setup_environment() {
    test -n "$1" || VERSION=5.9
    test -n "$1" && VERSION=$1
    test -n "$3" || SUDO=sudo
    test -n "$3" && SUDO=
    test "$3" = "sudo" && SUDO=sudo
}

save_sources() {
    test -d /usr/local/src/ncurses || sudo mkdir -p /usr/local/src/ncurses
    sudo cp -a ncurses-$VERSION /usr/local/src/ncurses
}

install_ncurses() {
    setup_environment $*
    mkdir install_ncurses
    cd install_ncurses
    wget http://ftp.gnu.org/pub/gnu/ncurses/ncurses-$VERSION.tar.gz
    tar xzvf ncurses-$VERSION.tar.gz
    cd ncurses-$VERSION
    test -n "$2" || ./configure --with-shared --with-normal --prefix=$HOME/local/ncurses/$VERSION
    test -n "$2" && ./configure --with-shared --with-normal --prefix=$2
    make
    $SUDO make install
    cd ../
    test -n "$3" || save_sources
    cd ../
    rm -rf install_ncurses
}

ping -c 1 id774.net > /dev/null 2>&1 || exit 1
install_ncurses $*
