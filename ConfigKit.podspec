#
# Be sure to run `pod lib lint ConfigKit.podspec'
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html

Pod::Spec.new do |s|
  s.name = 'ConfigKit'
  s.version = '1.1.5'
  s.summary = 'Configuration toolkit.'

  s.description = <<-DESC
Configuration toolkit.
System style, Language setter.
                       DESC

  s.homepage = 'http://192.168.7.2:8081/docs/hacomp%2FConfigKit.git'

  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'Luo Yu' => 'indie.luo@gmail.com' }
  s.source = { :git => 'http://192.168.7.2:8081/r/hacomp/ConfigKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://weibo.com/blodely'

  s.ios.deployment_target = '9.0'

  s.source_files = 'ConfigKit/Classes/**/*', 'ConfigKit/Configurations/*.plist'
  
  s.resource_bundles = {
    'ConfigKitRes' => ['ConfigKit/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.frameworks = 'UIKit'
  s.dependency 'FCFileManager', '~> 1.0.18'

end
