Gem::Specification.new do |s|
  s.name                  = 'paystand'
  s.version               = '0.0.1'
  s.date                  = '2018-08-06'
  s.summary               = 'Ruby library for the PayStand API'
  s.authors               = ['Hint']
  s.files                 = Dir['lib/**/*.rb']
  s.license               = 'MIT'
  s.required_ruby_version = '>= 2.4'

  s.add_dependency 'faraday', '~> 0.15.2', '>= 0.15'
  s.add_dependency 'faraday_middleware', '~> 0.12.2', '>= 0.12'
  s.add_dependency 'webmock', '~> 3.4.2', '>= 3'
  s.add_dependency 'activesupport', '>= 4'
end
