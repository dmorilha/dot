#!/bin/bash

#FOR MACOSX USERS PLEASE INSTALL GSED FROM MACPORTS
SED_BINARY=${SED_BINARYL:-$(which gsed)};
SED_BINARY=${SED_BINARY:-$(which sed)};

SVN_BINARY=$(which svn);

case $1 in

    "commit")

        assets=( );

        for asset in ${@:2};
        do
            [[ -r "${asset}" ]] && assets=( "${assets[@]}" "${asset}" );
        done;

        files=( );

        for file in $($SVN_BINARY status "${assets[@]}" | $SED_BINARY -r -n 's/^[AM].{7}(.+)/\1/p');
        do
            [[ -f "${file}" && -w "${file}" ]] && files=( "${files[@]}" "${file}" );
        done;

        [[ ${#files} -gt 0 ]] && $SED_BINARY -r -i "s/^[ \t]*$//g; :a; s/^([ ]*)\t/\1    /g; ta;" "${files[@]}";

        $SVN_BINARY "$@";
        ;;

    "diff")

        #append sed to the command.
        $SVN_BINARY "$@" | $SED_BINARY -r ":a; s/^([-+><][ ]*)\t/\1    /g; ta;";
        ;;

    *)
        $SVN_BINARY "$@";
        ;;
esac
