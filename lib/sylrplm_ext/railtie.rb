require 'sylrplm_ext/sylrplm_extensions_helpers'

module SylrplmExt
	class Railtie < Rails::Railtie
		initializer "sylrplm_ext.view_helpers" do

			puts "******************************** Railtie"

			ActionView::Base.send :include, SylrplmExt::SylrplmExtensionsHelper

		end
	end
end