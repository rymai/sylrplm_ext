require 'rails'

module SylrplmExt
  class Engine < ::Rails::Engine
    initializer 'helpers' do |app|
      ActionView::Base.send :include, SylrplmExt::SylrplmExtensionsHelper
    end
  end
end
