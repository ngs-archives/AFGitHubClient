Pod::Spec.new do |s|
  s.name     = 'AFGitHubClient'
  s.version  = '0.0.1'
  s.license  = 'MIT'
  s.summary  = '.'
  s.homepage = 'https://github.com/ngs/AFGitHubClient'
  s.author   = { 'Atsushi Nagase' => 'a@ngs.io' }
  s.source   = { :git => 'https://github.com/ngs/AFGitHubClient.git' } #, :tag => '0.0.1' }
  s.source_files = 'AFGitHubClient'
  s.requires_arc = true

  s.dependency 'AFNetworking', '~>1.0'
  s.dependency 'AFOAuth2Client', '~>0.1.0'

  s.ios.deployment_target = '5.0'

  s.osx.deployment_target = '10.7'

end
