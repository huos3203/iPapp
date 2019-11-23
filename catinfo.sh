#! /bin/sh
#
# test.sh
# Copyright (C) 2019 itboyer <itboyer@iTBoyerdeMacBook-Air.local>
#
# Distributed under terms of the MIT license.
#

TITLE=$ipaName
SUBTITLE=$ipaName
ICONURL=$ipaBaseURL/icon.png
FILEURL=$1

cat << EOF > info.plist
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
               <string>$SUBTITLE</string>
               <key>title</key>
               <string>$TITLE</string>
           </dict>
       </dict>
   </array>
</dict>
</plist>
EOF
