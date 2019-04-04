use_frameworks!

def settings
  platform :ios, '12.0'
end

def pods
  pod 'Bolts',          '~> 1.9',   :modular_headers => true, :inhibit_warnings => true
  pod 'FacebookCore',   '~> 0.5',   :inhibit_warnings => true
  pod 'FacebookLogin',  '~> 0.5',   :inhibit_warnings => true
  pod 'FacebookShare',  '~> 0.5',   :inhibit_warnings => true
  pod 'FBSDKCoreKit',   '~> 4.37',  :modular_headers => true, :inhibit_warnings => true
  pod 'FBSDKLoginKit',  '~> 4.37',  :modular_headers => true, :inhibit_warnings => true
  pod 'FBSDKShareKit',  '~> 4.37',  :modular_headers => true, :inhibit_warnings => true
  pod 'RxSwift',        '~> 4.0'
  pod 'RxCocoa',        '~> 4.0'
  pod 'RxDataSources',  '~> 3.0'
end

def setup
  settings
  pods
end

target 'iOSProjectSwift' do
  setup
end
