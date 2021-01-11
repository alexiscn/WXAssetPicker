Pod::Spec.new do |s|
  s.name         = 'WXAssetPicker'
  s.version      = '0.1.0'
  s.license = 'MIT'
  s.requires_arc = true
  s.source = { :git => 'https://github.com/alexiscn/WXAssetPicker.git', :tag => s.version.to_s }

  s.summary         = 'WeChat Asset Picker'
  s.homepage        = 'https://github.com/alexiscn/WXAssetPicker'
  s.license         = { :type => 'MIT' }
  s.author          = { 'xushuifeng' => 'shuifengxu@gmail.com' }
  s.platform        = :ios
  s.swift_version   = '5.0'
  s.source_files    =  'Sources/**/*.{swift}'
  s.ios.deployment_target = '11.0'
  
  s.resource_bundle = { 'Media' => 'Sources/Media.xcassets'}
  
end
