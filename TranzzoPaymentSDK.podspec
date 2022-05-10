Pod::Spec.new do |spec|

  spec.name          = 'TranzzoPaymentSDK'
  spec.version       = '1.0.0'
  spec.summary       = 'TranzzoPaymentSDK'
  spec.description   = 'Framework for Payments'
  spec.homepage      = 'https://tranzzo.ua'
  spec.license       = 'MIT'
  spec.license       = { :type => 'MIT', :file => 'LICENSE.md' }
  spec.author        = { 'Vitalii Stepanov' => 'v.stepanov@tranzzo.com' }
  spec.platform      = :ios, "11.0"
  spec.swift_version = '5.0'
  spec.vendored_frameworks = 'Sources/TranzzoPaymentSDK.framework'
  spec.dependency 'PayCardsRecognizer', '1.1.6'
  spec.dependency 'OwlKit'
  spec.dependency 'AnyFormatKit'
end
