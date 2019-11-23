#! /bin/sh
#
# test.sh
# Copyright (C) 2019 itboyer <itboyer@iTBoyerdeMacBook-Air.local>
#
# Distributed under terms of the MIT license.
#
## 创建目录
export ipaName=$1
##需要安装gem install chinese_pinyin
# echo "    123  567   " | tr -d '[ \t]'
pinyin=$(ch2py $ipaName)
ipaName_pinyin=$(echo $pinyin | tr -d '[ \t]')
ipaFileURL=$2
export ipaBaseURL=https://huos3203.github.io/iPapp/$ipaName_pinyin
mkdir $ipaName_pinyin
cd $ipaName_pinyin
## 在目录中新建install.html
source ../catinstall.sh 
## 新建info.plist
source ../catinfo.sh $ipaFileURL
## 发布到readme.md
source ../catreadme.sh $ipaName_pinyin
#生产二维码:需要安装：pip3 install myqr
myqr $ipaBaseURL/install.html -n icon.png  -d ./
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
