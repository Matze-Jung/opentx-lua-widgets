#!/bin/bash

if [ -d .git ]; then
    ORIGIN=$(basename `git config --get remote.origin.url`)
    ARCHIVE="releases/${ORIGIN//.git/}_$(git describe --abbrev=0 --tag).zip"

    echo "creating archive ..."
    mkdir -p releases
    rm -fv $ARCHIVE
    cd obj

    if [[ "$OSTYPE" != "win32" && "$OSTYPE" != "msys" ]]; then
        # linux zip
        zip -r9q "../${ARCHIVE}" ./*
    else
        # win 7zip
        7z a -r -mx9 -bb0 "../${ARCHIVE}" ./*
    fi
    cd ..
    echo
    echo -e "\e[1m${ARCHIVE}\e[1m\e[0m \e[0m"
    echo
fi
