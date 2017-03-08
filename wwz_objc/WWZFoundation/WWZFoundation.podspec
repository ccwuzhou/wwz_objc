#
#  Be sure to run `pod spec lint WWZFoundation.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "WWZFoundation"
  s.version      = "1.1.1"
  s.summary      = "A short description of WWZFoundation."

  s.homepage     = "https://github.com/ccwuzhou/WWZFoundation"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "wwz" => "wwz@zgkjd.com" }

  s.platform     = :ios

  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/ccwuzhou/WWZFoundation.git", :tag => "#{s.version}" }

  # s.source_files  = "WWZFoundation/*.{h,m}"

  # s.public_header_files = "WWZSocket/WWZSocket.h"

  s.requires_arc = true

  s.framework  = "UIKit"

  s.subspec 'WWZFoundation' do |ss|
    ss.source_files = "WWZFoundation/*.{h,m}"
  end
  s.subspec 'Foundation+WWZ' do |ss|
    ss.source_files = "Foundation+WWZ/*.{h,m}"
  end
end
