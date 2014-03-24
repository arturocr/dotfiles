#!zsh
gopen (){
    
    GIT='git'

    if test `uname` = "Darwin" ; then
        SED_OPT='-E'
        OPEN='open'
    else
        SED_OPT='-r'
        OPEN=''
    fi

    FETCH_URL=`$GIT remote show origin -n  | sed -n '/Fetch URL/p' | awk '{print $3}' | sed $SED_OPT 's/[:@]/ /g' `
    HOST=`echo $FETCH_URL | awk '{print $2}' `
    REPOS=`echo $FETCH_URL | awk '{print $3}' | sed 's/.git$//'`
    ORIGIN="http://$HOST/"
    BRANCH=`$GIT branch | fgrep '*' | sed 's/^* //'`


    echo $HOST | 'egrep' -q '^gist'
HOST_STARTS_W_GIST=$? # gist.github.com
echo $REPOS | 'egrep' -q '^gist\b'
REPOS_STARTS_W_GIST=$? # enterprise

if test $HOST_STARTS_W_GIST = 0 -o $REPOS_STARTS_W_GIST = 0; then
    GIST=YES
else
    GIST=NO
fi

COMMIT=$1
if test "x$COMMIT" = "x"  ; then
    if test $GIST = "YES" ; then
        URL="$ORIGIN$REPOS"
    else
        if test "x$BRANCH" = "x(no branch)"; then
            URL="$ORIGIN$REPOS"
        else
            URL="$ORIGIN$REPOS/tree/$BRANCH/$COMMIT"
        fi
    fi
else
    if test $GIST = "YES" ; then
        URL="$ORIGIN$REPOS/$COMMIT"
    else
        URL="$ORIGIN$REPOS/commit/$COMMIT"
    fi
fi
echo $URL
if test "x" != "x$OPEN" ; then
    $OPEN "$URL"
fi
}