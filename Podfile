platform :ios, '9.0'

target 'TMDb' do
  use_frameworks!

  def test_pods
    pod 'Quick', '~> 1.2'
    pod 'Nimble', '~> 7.0'
  end

  target 'TMDbTests' do
    inherit! :search_paths
    test_pods
  end

  target 'TMDbKitTests' do
    inherit! :search_paths
    test_pods
  end

end
