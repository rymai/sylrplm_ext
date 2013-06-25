# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sylrplm_ext/version'

Gem::Specification.new do |s|
	s.name          = 'sylrplm_ext'
	s.version       = SylrplmExt::VERSION
	s.authors       = ['sylvani']
	s.email         = ['sylvani@laposte.net']
	s.description   = %q{PLM extensions: select in/out, select in list}
	s.summary       = %q{PLM extensions}
	s.homepage      = ''

	s.add_development_dependency 'rspec'

  s.files = Dir['{app,lib}/**/*'] + ['LICENSE', 'Rakefile', 'README.md']
end
