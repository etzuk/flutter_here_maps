#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_here_maps'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC

A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'HEREMaps'
  s.dependency 'SwiftProtobuf', '~> 1.0'
  s.ios.deployment_target = '8.0'
#  s.preserve_paths = 'NMAKit.framework'
#  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework NMAKit' }
#  s.vendored_frameworks = 'NMAKit.framework'

end

