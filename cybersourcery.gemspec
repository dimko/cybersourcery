$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'cybersourcery/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'cybersourcery'
  s.version     = Cybersourcery::VERSION
  s.authors     = ['Michael Toppa']
  s.email       = ['public@toppa.com']
  s.homepage    = 'https://github.com/promptworks/cybersourcery'
  s.summary     = %q{A pain removal gem for working with Cybersource Secure Acceptance Silent Order POST}
  s.description = %q{Cybersourcery takes care of the most difficult aspects of working with Cybersource in Rails. It makes as few assumptions as possible about your business requirements, allowing you to use any subset of features appropriate to your needs.}

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.rdoc']

  s.add_dependency 'activesupport', '>= 3.1'
  s.add_dependency 'activemodel',   '>= 3.1'

  s.add_development_dependency 'bundler', '>= 1.6'
  s.add_development_dependency 'rake',    '>= 10.3'
end
