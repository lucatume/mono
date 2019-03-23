#!/usr/bin/env bash

set -e
set -x

CURRENT_BRANCH="1.0"

function split()
{
    SHA1=`./bin/splitsh-lite --prefix=$1`
    git push $2 "$SHA1:refs/heads/$CURRENT_BRANCH" -f
}

function remote()
{
    git remote add $1 $2 || true
}

git pull origin $CURRENT_BRANCH

remote component-one git@github.com:lucatume/component-one.git
remote comptwont-two git@github.com:lucatume/comptwont-two.git

split 'src/Mono/ComponentOne' component-one
split 'src/Mono/ComponentTwo' component-two
