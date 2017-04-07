Pod::Spec.new do |s|
  s.name         = "YYBHUDView"
  s.version      = "0.0.1"
  s.summary      = "An UseFul HUDView Tool."
  s.description  = "An UseFul HUDView Tool need add Masonry."
  s.homepage     = "https://github.com/damonyyb/YYBView"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "damonyyb" => "961355618@qq.com" }
  s.source       = { :git => "https://github.com/damonyyb/YYBView.git", :tag => "#{s.version}" }
  s.ios.deployment_target = '8.0'
  s.source_files = "YYBHUDView/**/*.{h,m}"
  s.frameworks   = "Foundation", "UIKit"
  s.dependency "Masonry"
  s.requires_arc = true
end