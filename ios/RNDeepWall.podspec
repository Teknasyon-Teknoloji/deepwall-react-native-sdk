
Pod::Spec.new do |s|
  s.name         = "RNDeepWall"
  s.version      = "2.9.4"
  s.summary      = "RNDeepWall"
  s.description  = <<-DESC
                  RNDeepWall
                   DESC
  s.homepage     = "https://deepwall.com"
  s.license      = "MIT"
  s.author       = { "Deepwall" => "https://deepwall.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk.git", :tag => s.version }
  s.source_files  = "**/*.{h,m}"
  s.requires_arc = true
  s.swift_version = '5.1'

  s.static_framework = true

  s.dependency "React"
  s.dependency "DeepWall", '2.4.1'
end
