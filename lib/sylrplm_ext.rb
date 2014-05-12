module SylrplmExt
	puts "******************************** sylrplm_ext *******************************"
	require "sylrplm_ext/engine"
	#require 'sylrplm_ext/railtie' #if defined?(Rails)
	require "sylrplm_ext/version"
	require 'sylrplm_ext/sylrplm_extensions_helper'

	ActionView::Base.send :include, SylrplmExt::SylrplmExtensionsHelper
	
end
