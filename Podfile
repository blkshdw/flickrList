# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'FlickrList' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FlickrList
  pod 'Alamofire', '~> 4.0'
  pod 'ObjectMapper', '~> 2.2'
  pod 'Kingfisher', '~> 3.0'
  pod 'PromiseKit', '~> 4.0'
  
  pod 'Crashlytics'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |configuration|
        configuration.build_settings['SWIFT_VERSION'] = '3.0'
      end
    end
  end
end
