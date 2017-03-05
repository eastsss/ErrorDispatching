#
# Be sure to run `pod lib lint ErrorDispatching.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ErrorDispatching'
  s.version          = '0.1.0'
  s.summary          = 'Reusable error handling in Swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/eastsss/ErrorDispatching'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anatoliy Radchenko' => 'anatox91@yandex.ru' }
  s.source           = { :git => 'https://github.com/eastsss/ErrorDispatching', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
      ss.source_files  = 'ErrorDispatching/Classes/Core/**/*'
      ss.framework  = 'Foundation', 'UIKit'
      ss.resource_bundles = {
          'ErrorDispatching' => ['ErrorDispatching/Assets/Core/**/*.{strings}']
      }
  end
end
