#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint wise_ai_ekyc.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'wise_ai_ekyc'
  s.version          = '0.0.1'
  s.summary          = 'A Wise AI eKYC Flutter plugin.'
  s.description      = <<-DESC
A Wise AI eKYC Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'GoogleMLKit/FaceDetection', '3.2.0'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  s.static_framework = true
  s.preserve_paths = 'WiseAISDK.framework'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework WiseAISDK' }
  s.vendored_frameworks = 'WiseAISDK.framework'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'wise_ai_ekyc_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end