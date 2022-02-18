Pod::Spec.new do |spec|
  spec.name         = "CryptoApiLib"
  spec.version      = "0.4.7"
  spec.summary      = "CryptoAPI iOS Framework"
  spec.homepage     = "https://github.com/cryptoapi-project/cryptoapi-swift"
  spec.license      = { :type => 'MIT', :file => 'LICENSE.md' }
  spec.authors      = {
        "mobile team @ pixelplex inc" => 'pixelplex.io'
  }
  spec.source       = { :git => 'https://github.com/cryptoapi-project/cryptoapi-swift.git', :tag => "#{spec.version}" }
  spec.platform     = :ios
  spec.swift_version = '5.0'
  spec.ios.deployment_target = "9.0"
  spec.source_files    = "CryptoAPI/**/*.{swift}"

end
