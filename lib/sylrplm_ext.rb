puts "******************************** sylrplm_ext"
require 'sylrplm_ext/railtie' #if defined?(Rails)
require "sylrplm_ext/version"
require 'app/helpers/sylrplm_extensions_helpers'

ActionView::Helper.send :include, SylrplmExt::SylrplmExtensionsHelper

=begin
require 'rails'
module SylrplmExt
  class Engine < ::Rails::Engine
    initializer 'helpers' do |app|
      ActionView::Base.send :include, SylrplmExt::SylrplmExtensionsHelper
    end
  end
end
=end
