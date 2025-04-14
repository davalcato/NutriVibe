# Uncomment the next line to define a global platform for your project
  platform :ios, '16.0'

install! 'cocoapods', :generate_multiple_pod_projects => false

target 'NutriVibe' do
  use_frameworks!
  use_modular_headers!

  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'

  pod 'FBSDKCoreKit'
  pod 'FBSDKLoginKit'
  pod 'FBSDKShareKit'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      # Set build configurations
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
        config.build_settings['EXCLUDED_ARCHITECTURES'] = 'i386'
        config.build_settings['ARCHS'] = 'arm64'

        # Fix for LD_RUNPATH_SEARCH_PATHS override warning
        if config.build_settings['LD_RUNPATH_SEARCH_PATHS']
          config.build_settings['LD_RUNPATH_SEARCH_PATHS'] = "$(inherited) " + config.build_settings['LD_RUNPATH_SEARCH_PATHS']
        else
          config.build_settings['LD_RUNPATH_SEARCH_PATHS'] = "$(inherited)"
        end
      end
    end
  end
end






  





