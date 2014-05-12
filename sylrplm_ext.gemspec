# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sylrplm_ext/version'

Gem::Specification.new do |spec|
  spec.name          = "sylrplm_ext"
  spec.version       = SylrplmExt::VERSION
  spec.authors       = ["sylvani"]
  spec.email         = ["sylvani@laposte.net"]
  spec.description   = %q{PLM extensions: select in/out, select in list}
  spec.summary       = %q{PLM extensions}
  spec.homepage      = "http://github.com/sylvani/sylrplm_ext"
  spec.license       = "MIT"
	
	spec.files = Dir["{app,lib}/**/*"] + ["LICENSE", "Rakefile", "README.md"]
	#spec.files = Dir['lib/**/*.rb'] 
	#spec.files += Dir['app/**/*.js']
	#spec.files.reject! { |fn| fn.include? "CVS" }

  #spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rails"
  spec.add_development_dependency "activesupport"
end
