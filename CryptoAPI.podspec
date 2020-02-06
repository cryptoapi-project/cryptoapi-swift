#
#  Be sure to run `pod spec lint CryptoAPI.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "CryptoAPI"
  spec.version      = "0.3.1"
  spec.summary      = "CryptoAPI iOS Framework"
  spec.homepage     = "https://gitlab.pixelplex.by/709-crypto-api-mobile-library/ios-framework"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.authors      = {
    "Fedorenko Nikita" => ''
  }
  spec.source       = { :git => 'https://gitlab.pixelplex.by/709-crypto-api-mobile-library/ios-framework.git' }
  spec.platform     = :ios
  spec.ios.deployment_target = "9.0"
  spec.source_files    = "CryptoAPI/**/*.{swift}"

end
