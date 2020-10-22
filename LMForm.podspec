#
# Be sure to run `pod lib lint LMForm.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LMForm'
  s.version          = '0.0.2'
  s.summary          = 'LMForm 动态配置表单解决方案'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
动态配置表单解决方案，支持文本，输入框，选择器，日期选择，输入限制与校验。
                       DESC

  s.homepage         = 'https://github.com/MaricleZhang/LMForm'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MaricleZhang' => 'maricle.zhang@gmail.com' }
  s.source           = { :git => 'https://github.com/MaricleZhang/LMForm.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'LMForm/Classes/**/*'
  
  s.resource_bundles = {
     'LMForm' => ['LMForm/Assets/*.png']
  }
 
  s.public_header_files = 'LMForm/Classes/**/*.h'
  s.dependency 'IQKeyboardManager', '~> 6.3.0'
end
