# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'
target 'NikeStore' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for NikeStore
pod 'SkyFloatingLabelTextField'
pod 'IQKeyboardManagerSwift'
pod ‘Alamofire’
pod ‘SwiftyJSON’
pod 'Kingfisher'
pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'
pod 'TransitionTreasury', '~> 4.0’
pod ‘TransitionAnimation’
end
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = ‘3.0.2’
        end
    end
  end