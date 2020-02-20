#
#  Be sure to run `pod spec lint CryptoAPI.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "CryptoAPI"
  spec.version      = "0.3.2"
  spec.summary      = "CryptoAPI iOS Framework"
  spec.homepage     = "https://github.com/cryptoapi-project/cryptoapi-swift"
  spec.license      = { :type => 'MIT', :file => 'LICENSE.md' }
  spec.authors      = {
    "Fedorenko Nikita" => '',
    "Sharaev Vladimir" => ''
  }
  spec.source       = { :git => 'https://github.com/cryptoapi-project/cryptoapi-swift.git', :tag => "{spec.version}" }
  spec.platform     = :ios
  spec.ios.deployment_target = "9.0"
  spec.source_files    = "CryptoAPI/**/*.{swift}"

end
