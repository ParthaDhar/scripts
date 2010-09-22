#!/bin/sh
#
########################################################################
# Install Programming Ruby
#
#  Maintainer: id774 <idnanashi@gmail.com>
#
#  v0.1 9/22,2010
#       First.
########################################################################

setup_environment() {
    case $OSTYPE in
      *darwin*)
        OWNER=root:wheel
        ;;
      *)
        OWNER=root:root
        ;;
    esac
}

apache_settings() {
    sudo vim /etc/apache2/sites-available/default
    sudo /etc/init.d/apache2 restart
}

create_html_link() {
    sudo chown -R $OWNER /usr/share/doc/rubybook/html
    sudo ln -s /usr/share/doc/rubybook/html /var/www/html
}

install_rubybook() {
    if [ `aptitude search rubybook | awk '/^i/' | wc -l` = 0 ]; then
        sudo aptitude -y install rubybook
    fi
}

main() {
    setup_environment
    install_rubybook
    create_html_link
    apache_settings
}

ping -c 1 -i 3 google.com > /dev/null 2>&1 || exit 1
main
