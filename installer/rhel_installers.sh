#!/bin/sh
#
########################################################################
# Batch Installers for RHEL
#
#  Maintainer: id774 <idnanashi@gmail.com>
#
#  v0.1 9/26,2011
#       First version.
########################################################################

build_vim() {
    $SCRIPTS/installer/install_ncurses.sh
    vi $SCRIPTS/installer/install_vim.sh
    $SCRIPTS/installer/install_vim.sh
}

install_dot_vim() {
    $SCRIPTS/installer/install_dotvim.sh
}

install_dot_zsh() {
    test -d ~/local/github || mkdir -p ~/local/github
    cd ~/local/github
    git clone git://github.com/id774/dot_zsh.git
    cd
    ln -s ~/local/github/dot_zsh
    ~/local/github/dot_zsh/install_dotzsh.sh
}

install_dot_emacs() {
    test -d ~/local/github || mkdir -p ~/local/github
    cd ~/local/github
    git clone git://github.com/id774/dot_emacs.git
    cd
    ln -s ~/local/github/dot_emacs
    ~/local/github/dot_emacs/install_dotemacs.sh
}

install_mew() {
    $SCRIPTS/installer/install_mew.sh /opt/emacs/23.3/bin/emacs
}

install_dot_files() {
    $SCRIPTS/installer/install_dotfiles.sh
}

install_sqlite() {
    $SCRIPTS/installer/install_sqlite.sh
}

install_svn() {
    $SCRIPTS/installer/install_rhel_svn.sh
}

install_ruby_and_rails() {
    $SCRIPTS/installer/install_ruby_and_rails.sh
}

install_coffeescript() {
    $SCRIPTS/installer/install_coffeescript.sh
}

install_samba() {
    wget http://bookmark.at-ninja.jp/bookmark/smb.conf
    sudo cp smb.conf /etc/samba/smb.conf
    rm smb.conf
    sudo smbpasswd -a $USER
}

install_truecrypt() {
    $SCRIPTS/installer/install_des.sh
    #$SCRIPTS/installer/install_crypt.sh src
    #$SCRIPTS/installer/install_crypt.sh win
    #$SCRIPTS/installer/install_crypt.sh mac
    $SCRIPTS/installer/install_crypt.sh linux-$1
}

setup_sysadmin_scripts() {
    $SCRIPTS/installer/setup_sysadmin_scripts.sh
}

setup_web() {
    test -d ~/local/github || mkdir -p ~/local/github
    cd ~/local/github
    git clone git://github.com/id774/intraweb-template.git
    cd
    ln -s ~/local/github/intraweb-template
    ~/local/github/intraweb-template/install_intraweb.sh
}

setup_rc_local() {
    $SCRIPTS/installer/install_rclocal.sh
}

add_blacklist() {
    test -r /etc/modprobe.d/blacklist && \
      sudo vi /etc/modprobe.d/blacklist
    test -r /etc/modprobe.d/blacklist.conf && \
      sudo vi /etc/modprobe.d/blacklist.conf
}

change_default() {
    sudo vi /etc/profile
    sudo vi /etc/crontab
    sudo vi /etc/anacrontab
    sudo vi /etc/pam.d/su
    sudo vi /etc/ssh/sshd_config
    sudo vi /etc/pam.d/sshd
    sudo vi /etc/pam.d/login
    sudo vi /etc/fstab
    sudo vi /etc/hosts
}

permission_for_src() {
    sudo chown -R root:root /usr/src
    sudo chown -R root:root /usr/local/src
}

erase_history() {
    test -f ~/.bash_history && sudo rm ~/.bash_history
    test -f ~/.mysql_history && sudo rm ~/.mysql_history
    test -f ~/.viminfo && sudo rm ~/.viminfo
}

operation() {
    #build_vim
    #install_dot_vim
    #install_dot_zsh
    #install_dot_emacs
    #install_mew
    #install_dotfiles
    #install_sqlite
    #install_svn
    #install_ruby_and_rails
    #install_coffeescript
    #install_samba
    #install_truecrypt amd64
    #setup_sysadmin_scripts
    #setup_web
    #setup_rc_local
    #add_blacklist
    #change_default
    #permission_for_src
    #erase_history
}

operation