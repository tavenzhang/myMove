use_frameworks! # Add this if you are targeting iOS 8+ or using Swift
#使用My.xcworkspace 不用生成新的
workspace 'TVideoRoom.xcworkspace'
xcodeproj 'TVideoRoom/TVideoRoom.xcodeproj'
# 该Target属于的工程
target :TVideoRoom do
xcodeproj 'TVideoRoom/TVideoRoom.xcodeproj'
pod 'SwiftyJSON' ,'3.1.1'
pod 'SnapKit','3.0.2'
pod 'CryptoSwift','0.6.5'
pod 'Alamofire', '4.0.1'
pod 'NSLogger/NoStrip','1.7.0'
pod 'SVProgressHUD','2.0.3'
pod 'SDWebImage', '3.8.2'
pod 'MJRefresh','3.1.12'
pod 'Fabric','1.6.11'
pod 'Crashlytics','3.8.3'
pod 'BBSZLib','0.0.2'
pod 'CocoaAsyncSocket','7.5.0'
end

target :TAmf3Socket do
xcodeproj 'TNetServer/TNetServer.xcodeproj'
pod 'BBSZLib','0.0.2'
pod 'CocoaAsyncSocket','7.5.0'
end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
