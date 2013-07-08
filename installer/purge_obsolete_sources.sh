#!/bin/sh
#
########################################################################
# Purge obsolete sources
#
#  Maintainer: id774 <idnanashi@gmail.com>
#
#  v0.1 7/8,2013
#       First.
########################################################################

purge_old_modules() {
    test -d /opt/ruby/1.9.2 && \
      sudo rm -rf /opt/ruby/1.9.2
    test -d /usr/local/src/ruby/ruby-2.0.0-p195 && \
      sudo rm -rf /usr/local/src/ruby/ruby-2.0.0-p195
    test -d /usr/local/src/ruby/ruby-2.0.0-p0 && \
      sudo rm -rf /usr/local/src/ruby/ruby-2.0.0-p0
    test -d /usr/local/src/ruby/ruby-1.9.3-p429 && \
      sudo rm -rf /usr/local/src/ruby/ruby-1.9.3-p429
    test -d /usr/local/src/ruby/ruby-1.9.3-p392 && \
      sudo rm -rf /usr/local/src/ruby/ruby-1.9.3-p392
    test -d /usr/local/src/ruby/ruby-1.9.3-p385 && \
      sudo rm -rf /usr/local/src/ruby/ruby-1.9.3-p385
    test -d /usr/local/src/ruby/ruby-1.9.3-p374 && \
      sudo rm -rf /usr/local/src/ruby/ruby-1.9.3-p374
    test -d /usr/local/src/ruby/ruby-1.9.3-p362 && \
      sudo rm -rf /usr/local/src/ruby/ruby-1.9.3-p362
    test -d /usr/local/src/ruby/ruby-1.9.3-p327 && \
      sudo rm -rf /usr/local/src/ruby/ruby-1.9.3-p327
    test -d /usr/local/src/ruby/ruby-1.9.3-p286 && \
      sudo rm -rf /usr/local/src/ruby/ruby-1.9.3-p286
    test -d /usr/local/src/ruby/ruby-1.9.3-p194 && \
      sudo rm -rf /usr/local/src/ruby/ruby-1.9.3-p194
    test -d /usr/local/src/ruby/ruby-1.9.3-p125 && \
      sudo rm -rf /usr/local/src/ruby/ruby-1.9.3-p125
    test -d /usr/local/src/ruby/ruby-1.9.3-p0 && \
      sudo rm -rf /usr/local/src/ruby/ruby-1.9.3-p0
    test -d /usr/local/src/ruby/ruby-1.9.2-p290 && \
      sudo rm -rf /usr/local/src/ruby/ruby-1.9.2-p290
    test -d /usr/local/src/ruby/branches/ruby_1_9_2 && \
      sudo rm -rf /usr/local/src/ruby/branches/ruby_1_9_2
    test -d /usr/local/src/ruby/branches/ruby_1_9_3 && \
      sudo rm -rf /usr/local/src/ruby/branches/ruby_1_9_3
}

purge_old_modules $*
