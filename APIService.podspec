#
# Be sure to run `pod lib lint APIService.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'APIService'
  s.version          = '0.1.0'
  s.summary          = 'A short description of APIService.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/wangxiangbo/APIService'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wangxiangbo' => 'laoyouhub@icloud.com' }
  s.source           = { :git => 'https://github.com/wangxiangbo/APIService.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '13.0'
  s.source_files = 'Sources/**/*'
  s.dependency 'Alamofire'
end
