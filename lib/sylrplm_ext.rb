module SylrplmExt
	fname="#{__FILE__}"
	
	puts "#{fname}: ******************************** sylrplm_ext *******************************"
	require "sylrplm_ext/version"
	require 'sylrplm_ext/sylrplm_extensions_helper'
	require 'sylrplm_ext/file_utils'

	ActionView::Base.send :include, SylrplmExt::SylrplmExtensionsHelper
	
	puts "#{fname}: sync_javascripts *******************************"
	#__FILE__ = /home/syl/trav/rubyonrails/sylrplm_ext/lib/sylrplm_ext.rb
	dir = "#{File.dirname(File.dirname(__FILE__))}/app/assets/javascripts"
	puts "#{fname}: dir=#{dir}"
	
  FileUtils.mkdir_p "public/javascripts/sylrplm_ext"
  
  FileUtils.sync_file "#{dir}/sylrplm_extensions.js",        "public/javascripts/sylrplm_ext/sylrplm_extensions.js"
  
  
 
end
