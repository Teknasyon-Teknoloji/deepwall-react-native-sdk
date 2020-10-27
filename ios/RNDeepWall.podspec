
Pod::Spec.new do |s|
  s.name         = "RNDeepWall"
  s.version      = "2.0.0"
  s.summary      = "RNDeepWall"
  s.description  = <<-DESC
                  RNDeepWall
                   DESC
  s.homepage     = "https://teknasyon.com"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "Teknasyon" => "https://teknasyon.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/Teknasyon-Teknoloji/deepwall-react-native-sdk.git", :tag => s.version }
  s.source_files  = "**/*.*"
  s.requires_arc = true
  s.swift_version = '5.1'


  s.dependency "React"
  s.dependency "DeepWall", '~> 2.0'
end
