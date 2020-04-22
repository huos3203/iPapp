#! /bin/sh
#
# test.sh
# Copyright (C) 2019 itboyer <itboyer@iTBoyerdeMacBook-Air.local>
#
# Distributed under terms of the MIT license.
# appUrl ipaPath ipafileUrl
# ipaPath:必填
#    1. 当已知ipafileUrl时，仅提供APP名称。
#    2. 当是本地ipa包时，只需提供ipa路径，操作过程：先将ipa包拷贝到iPapp git库中，发布到github-page上。
# 功能:
#   创建四个文件：intall.html index.html info.plist
#   更新：readme.md
appUrl()
{
    ipaPath=$1
    FILEURL=$2

    fromDir=`pwd`
    export ipappDir=$(cd `dirname $0`; pwd)
    echo "app发布目录：$ipappDir"
    cd $ipappDir
    
    ## 全拼音
    ipaName=${ipaPath%%.*}
    ##需要安装gem install chinese_pinyin
    # echo "    123  567   " | tr -d '[ \t]'
    pinyin=$(ch2py $ipaName)
    IPADir=$(echo $pinyin | tr -d '[ \t]')
    ## 创建目录
    mkdir $IPADir
    if [ ! -f "$ipaPath" ]; then
        cp -f $ipaPath $IPADir
    fi

    ## 初始化变量
    githubURL=https://it-boyer.github.io/iPapp/$IPADir
    InfoURL=$githubURL/info.plist
    ICONURL=$githubURL/icon.png


    if [ "$FILEURL" = "" ]; then
        ## 在没有指定ipaUrl，指向github目录文件
        FILEURL=$githubURL/$IPAName.ipa
    fi

    #生产二维码:需要安装：pip3 install myqr
    myqr $githubURL/install.html -n icon.png  -d $IPADir

    ## 创建 install.html
    cat << EOF > $IPADir/install.html
    <html>
    <head>
    <title>$IPAName</title>
    <meta http-equiv="Content-Type" content="text/HTML; charset=utf-8">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
    <script type="text/javascript">
    function doLocation(url)
    {
      var a = document.createElement("a");
      if(!a.click) {
        window.location = url;
        return;
      }
      a.setAttribute("href", url);
      a.style.display = "none";
      document.body.appendChild(a);
      a.click();
    }
    </script>
    </head>
    <body>
    <script type="text/javascript">
    doLocation('itms-services://?action=download-manifest&url=$InfoURL');
    </script>
    </body>
    </html>
    EOF

    ## 创建 index.html
    cat << EOF > $IPADir/index.html
     <html>
    <head>
    <title>iOS APP 一键安装</title>
    <meta http-equiv="Content-Type" content="text/HTML; charset=utf-8">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;" name="viewport" />
    </head>
    <body>
    1、<a href="itms-services://?action=download-manifest&url=$InfoURL">内测iOS设备浏览器访问本页，点这儿一键安装《$IPAName》应用。</a>
    <br /><br />
    2、iPhone、iPad还可以通过拍摄以下二维码自动安装《$IPAName》APP应用：
    <br />
    <img src="$ICONURL" border="0">
    </body>
    </html>

    EOF

    ## 创建 info.plist
    cat << EOF > $IPADir/info.plist
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
       <key>items</key>
       <array>
           <dict>
               <key>assets</key>
               <array>
                   <dict>
                       <key>kind</key>
                       <string>software-package</string>
                       <key>url</key>
                       <string>$FILEURL</string>
                   </dict>
                   <dict>
                       <key>kind</key>
                       <string>display-image</string>
                       <key>needs-shine</key>
                       <true/>
                       <key>url</key>
                       <string>$ICONURL</string>
                   </dict>
               <dict>
                       <key>kind</key>
                       <string>full-size-image</string>
                       <key>needs-shine</key>
                       <true/>
                       <key>url</key>
                       <string>$ICONURL</string>
                   </dict>
               </array><key>metadata</key>
               <dict>
                   <key>bundle-identifier</key>
                   <string>com.yourdomain.productname</string>
                   <key>bundle-version</key>
                   <string>1.0.0</string>
                   <key>kind</key>
                   <string>software</string>
                   <key>subtitle</key>
                   <string>$IPAName</string>
                   <key>title</key>
                   <string>$IPAName</string>
               </dict>
           </dict>
       </array>
    </dict>
    </plist>
    EOF


    # 更新readme
    cat << EOF >> README.md
    ### $IPAName
    扫描二维码安装

    ![]($ICONURL)

    [更多安装方式]($IPADir/index.html)

    EOF
    cd $fromDir
}
