puts "******************************** sylrplm_ext"
require 'sylrplm_ext/railtie' #if defined?(Rails)
require 'sylrplm_ext/sylrplm_extensions_helpers'
require "sylrplm_ext/version"
ActionView::Helper.send :include, SylrplmExt::SylrplmExtensionsHelper


    
