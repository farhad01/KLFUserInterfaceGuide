#
# Be sure to run `pod lib lint KLFUserInterfaceGuide.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KLFUserInterfaceGuide'
  s.version          = '0.1.0'
  s.summary          = 'Showcase app tutorial for user onboarding'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Lightweight and Easy to use ios library to make the user familiar with your app.
  it requires a view and a text and an optional tag so you will not worry about presentation next time. it will use the tag to set a flag on UserDefault. you can present it multiple time after each other it has queueing mechanism and you will not get UIViewController presentation error.
                       DESC

  s.homepage         = 'https://github.com/farhad01/KLFUserInterfaceGuide'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jebelli.farhad@gmail.com' => 'jebelli.farhad@gmail.com' }
  s.source           = { :git => 'https://github.com/farhad01/KLFUserInterfaceGuide.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.swift_version = '5.0'
  
  s.source_files = 'KLFUserInterfaceGuide/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KLFUserInterfaceGuide' => ['KLFUserInterfaceGuide/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
