#! /bin/sh
#
# test.sh
# Copyright (C) 2019 itboyer <itboyer@iTBoyerdeMacBook-Air.local>
#
# Distributed under terms of the MIT license.
#
fromDir=`pwd`
export ipappDir=$(cd `dirname $0`; pwd)
echo "app发布目录：$ipappDir"
cd $ipappDir
## 创建目录
export ipaName=$1
##需要安装gem install chinese_pinyin
# echo "    123  567   " | tr -d '[ \t]'
pinyin=$(ch2py $ipaName)
ipaName_pinyin=$(echo $pinyin | tr -d '[ \t]')
ipaFileURL=$2
export ipaBaseURL=https://it-boyer.github.io/iPapp/$ipaName_pinyin
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
source ../deploy.sh
# 返回原目录
cd $fromDir
