#! /bin/sh
#
# test.sh
# Copyright (C) 2019 itboyer <itboyer@iTBoyerdeMacBook-Air.local>
#
# Distributed under terms of the MIT license.
#
## 部署 deploy
deploy()
{
    cd ../
    git remote -v

    git add .

    msg="rebuilding site `date`"

    if [ $# -eq 1 ]
    then msg="$1"
    fi

    git commit -m "$msg"

    # push source to github

    git push origin HEAD:master
}

deploy
