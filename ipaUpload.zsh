# 说明：https://help.apple.com/itc/transporteruserguide/#/itc0d5b535bf
alias transporter='/usr/local/itms/bin/iTMSTransporter'

# 获取账户权限清单
# transporter -m provider -u 724987481@qq.com -p lfyj-mrsu-dlvy-tpcl -v off

# 上传ipa包 在 macOS 上使用 -assetFile 上传 App
# transporter -m upload -assetFile ~/Downloads/JHUniversalApp-2.ipa -u 724987481@qq.com -p lfyj-mrsu-dlvy-tpcl -v eXtreme

# 验证 暂时没有找到验证ipa包的命令
# transporter -m verify -f ~/Downloads/邑餐食安.itmsp -u 724987481@qq.com -p lfyj-mrsu-dlvy-tpcl -v eXtreme

ipaUpload()
{
    ipaPath=$1
    echo "选择 验证:v  上传:u"
    read origin
    usename="724987481@qq.com"
    password="lfyj-mrsu-dlvy-tpcl"
    
    # 在本地shell脚本中ssh到远程服务器并执行命令
    if [ "$origin" = "v" ]; then
        echo "验证ipa：${ipaPath}"
        xcrun altool --validate-app -f $ipaPath -t iOS -u $usename -p $password
    else
        echo "上传ipa：${ipaPath}"
        xcrun altool --upload-app -f $ipaPath -t iOS -u $usename -p $password
    fi
}
