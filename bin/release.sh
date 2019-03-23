#!/usr/bin/env bash

set -e

if (( "$#" != 1 ))
then
    echo "Tag has to be provided"

    exit 1
fi

CURRENT_BRANCH="1.0-dev"
VERSION=$1

# Always prepend with "v"
if [[ $VERSION != v*  ]]
then
    VERSION="v$VERSION"
fi

for REMOTE in component-one component-two
do
    echo ""
    echo ""
    echo "Releasing $REMOTE";

    TMP_DIR="/tmp/mono-split"
    REMOTE_URL="git@github.com:lucatume/$REMOTE.git"

    rm -rf $TMP_DIR;
    mkdir $TMP_DIR;

    (
        cd $TMP_DIR;

        git clone $REMOTE_URL .
        git checkout "$CURRENT_BRANCH";

        git tag $VERSION
        git push origin --tags
    )
done
