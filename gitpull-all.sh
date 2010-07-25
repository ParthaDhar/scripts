#!/bin/sh

########################################################################
# Pulling all repository.
#
#  Maintainer: id774 <idnanashi@gmail.com>
#
#  v1.0 7/26,2010
#       Stable.
########################################################################

gitpull() {
    echo "Pulling $1 $3 $4"
    if [ -d $HOME/local/$1/$3 ]; then
        cd $HOME/local/$1/$3
        test -n "$4" && git reset --hard
        git pull
    else
        cd $HOME/local/$1
        git clone git://github.com/$2/$3.git
    fi
}

assembla_git() {
    echo "Pulling $1 $2 $3"
    if [ -d $HOME/local/$1/$2 ]; then
        cd $HOME/local/$1/$2
        test -n "$3" && git reset --hard
        git pull
    else
        cd $HOME/local/$1
        git clone git://git.assembla.com/$2.git
    fi
}

debian_monthly_report() {
    echo "Pulling $1 $2 $3"
    if [ -d $HOME/local/$1/$2 ]; then
        cd $HOME/local/$1/$2
        test -n "$3" && git reset --hard
        $1 pull
    else
        cd $HOME/local/$1
        git clone git://git.debian.org/$1/tokyodebian/$2.git
        cd monthly-report
    fi
    cp -p git-pre-commit.sh .git/hooks/pre-commit
}

emacswiki_get() {
    echo "Pulling $1"
    test -d $HOME/local/$1 || mkdir -p $HOME/local/$1
    cd $HOME/local/$1
    test -f $1.el && rm $1.el
    wget http://www.emacswiki.org/emacs/download/$1.el
    diff $HOME/local/$1/$1.el $HOME/.emacs.d/elisp/3rd-party/$1.el
}

repoorcz_pull() {
    echo "Pulling $1 $2 $3"
    if [ -d $HOME/local/$1/$2 ]; then
        cd $HOME/local/$1/$2
        test -n "$3" && git reset --hard
        $1 pull
    else
        cd $HOME/local/$1
        git clone git://repo.or.cz/$2.git
    fi
}

anything_get_all() {
    repoorcz_pull git anything-config $*
    #emacswiki_get anything
}

assembla_git_all() {
    assembla_git git 774-gthumb $*
}

gitpull_all() {
    gitpull github id774 id774.github.com $*
    gitpull github id774 termtter-plugins $*
    gitpull github jugyo termtter $*
    gitpull github hayamiz twittering-mode $*
    gitpull github miyagawa plagger $*
    gitpull github m2ym auto-complete $*
    gitpull github mooz js2-mode $*
}

main() {
    test -d $HOME/local/github || mkdir -p $HOME/local/github
    test -d $HOME/local/git || mkdir -p $HOME/local/git
    debian_monthly_report git monthly-report $*
    assembla_git_all $*
    anything_get_all $*
    gitpull_all $*
}

ping -c 1 -i 3 google.com > /dev/null 2>&1 || exit 1
main $*
