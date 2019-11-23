#! /bin/sh
#
# test.sh
# Copyright (C) 2019 itboyer <itboyer@iTBoyerdeMacBook-Air.local>
#
# Distributed under terms of the MIT license.
#

##app目录
appicondir=$1
cat << EOF >> ../README.md
### $ipaName
扫描二维码安装

![](/$appicondir/icon.png)

[更多安装方式](/$appicondir/index.html)

EOF
