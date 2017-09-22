Pod::Spec.new do |s|
  s.name             = 'ErrorDispatching'
  s.version          = '0.1.3'
  s.summary          = 'A simple and reusable error handling in Swift'
  s.homepage         = 'https://github.com/eastsss/ErrorDispatching'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Anatoliy Radchenko' => 'anatox91@yandex.ru' }
  s.source           = { :git => 'https://github.com/eastsss/ErrorDispatching.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.default_subspec = "Core"

  s.subspec "Core" do |ss|
      ss.source_files  = 'ErrorDispatching/Classes/Core/**/*'
      ss.framework  = 'Foundation', 'UIKit'
      ss.resource_bundles = {
          'ErrorDispatching' => ['ErrorDispatching/Assets/Core/**/*.{strings}']
      }
  end
  
  s.subspec "ReactiveSwift" do |ss|
      ss.source_files = 'ErrorDispatching/Classes/ReactiveSwift/**/*'
      ss.dependency 'ErrorDispatching/Core'
      ss.dependency 'ReactiveSwift', '~> 2.0'
      ss.dependency 'Result', '~> 3.0'
  end
  
  s.subspec "Moya" do |ss|
      ss.source_files = 'ErrorDispatching/Classes/Moya/**/*'
      ss.dependency 'ErrorDispatching/Core'
      ss.dependency 'Moya', '~> 9.0'
  end
end
