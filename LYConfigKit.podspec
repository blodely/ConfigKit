#
# Luo Yu

Pod::Spec.new do |s|
  s.name = 'LYConfigKit'
  s.version = '1.12.0'
  s.summary = 'Configuration toolkit.'

  s.description = <<-DESC
Configuration toolkit.
System style.
Language setter.
Libs configuration file reader.
Versions: 1.2.x=>iOS7; 1.12.x=>Xcode12.iOS9
                       DESC

  s.homepage = 'https://github.com/blodely/ConfigKit'

  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.author = { 'Luo Yu' => 'indie.luo@gmail.com' }
  s.source = { :git => 'https://github.com/blodely/ConfigKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://weibo.com/blodely'

  s.ios.deployment_target = '9.0'

  s.source_files = 'LYConfigKit/Classes/**/*'
  
  s.resources = 'LYConfigKit/Configurations/*.plist'
  
  s.resource_bundles = {
    'LYConfigKitRes' => ['LYConfigKit/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'

  s.ios.frameworks = 'UIKit', 'AudioToolbox'
  s.dependency 'FCFileManager', '~> 1.0.18'

end
