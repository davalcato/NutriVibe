# Uncomment the next line to define a global platform for your project
  platform :ios, '16.0'

# Only use CDN (no other sources)
source 'https://cdn.cocoapods.org/'

install! 'cocoapods',
  :generate_multiple_pod_projects => false

target 'NutriVibe' do
  use_frameworks!
  use_modular_headers!

  # Firebase
  pod 'FirebaseCore'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'

  # Facebook
  pod 'FBSDKCoreKit'
  pod 'FBSDKLoginKit'
  pod 'FBSDKShareKit'

  # Google
  pod 'GoogleSignIn'
  pod 'GoogleSignInSwiftSupport'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
        config.build_settings['EXCLUDED_ARCHITECTURES'] = 'i386'
        config.build_settings['ARCHS'] = 'arm64'
      end
    end
  end
end














  





