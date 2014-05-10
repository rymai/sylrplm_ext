# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'sylrplm_ext/version'

Gem::Specification.new do |gem|
	gem.name          = "sylrplm_ext"
	gem.version       = SylrplmExt::VERSION
	gem.authors       = ["sylvani"]
	gem.email         = ["sylvani@laposte.net"]
	gem.description   = %q{PLM extensions: select in/out, select in list, }
	gem.summary       = %q{PLM extensions:}
	gem.homepage      = "http://github.com/sylvani/sylrplm_ext"
	gem.add_development_dependency "rspec"
	
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ["lib"]

	#s.add_development_dependency 'rspec'
  #s.files = Dir['{app,lib}/**/*'] + ['LICENSE', 'Rakefile', 'README.md']
	gem.add_development_dependency "minitest"
  gem.add_development_dependency "guard-minitest"
  gem.add_development_dependency "rake"
  gem.add_dependency "railties"
end
