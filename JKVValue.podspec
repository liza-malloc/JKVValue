Pod::Spec.new do |s|
  s.name         = "JKVValue"
  s.version      = "1.3.3"
  s.summary      = "A simple Value Object library."

  s.description  = <<-DESC
                   A no-frills Value Object implementation. It only does one thing,
                   making [Value](http://en.wikipedia.org/wiki/Value_object)
                   [Objects](http://martinfowler.com/bliki/ValueObject.html) easy.

                   All standard methods for NSObject, NSSecureCoding, NSCopying are
                   implemented:

                   * `-[initWithCoder:]`
                   * `-[encodeWithCoder:]`
                   * `-[copyWithZone:]`
                   * `-[mutableCopyWithZone:]`
                   * `-[description]`
                   * `-[debugDescription]`
                   * `-[isEqual:]`
                   * `-[hash]`

                   When you inherit `JKVValue` or `JKVMutableValue`. Both classes
                   will introspect the properties to provide all the behavior
                   for the standard methods.
                   DESC

  s.homepage     = "https://github.com/jeffh/JKVValue"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Jeff Hui" => "jeff@jeffhui.net" }

  #s.ios.deployment_target = '6.0'
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.8'
  s.source       = { :git => "https://github.com/jeffh/JKVValue.git", :tag => "v#{s.version}" }
  s.source_files  = 'JKVValue/**/*.{h,m}'
  s.public_header_files = 'JKVValue/Public/**/*.h'
  s.requires_arc = true
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64 i386'
  }
end
