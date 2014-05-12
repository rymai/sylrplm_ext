# generator sylrplm_ext
module Sylrplm
  class ExtGenerator < ::Rails::Generators::Base
    source_root File.expand_path('..', __FILE__)

    # Copy all needed stylesheets in the asset directory of the application
    def copy_stylesheets
      FileUtils.mkdir_p "app/assets/stylesheets/bootstrap_overrides"

      copy_file "../../../app/assets/stylesheets/twitter/bootstrap.css.scss",        "app/assets/stylesheets/bootstrap_overrides/base.css.scss"
      copy_file "../../../app/assets/stylesheets/twitter/bootstrap/_variables.scss", "app/assets/stylesheets/bootstrap_overrides/variables.css.scss"
      copy_file "templates/bootstrap_overrides.css.scss",                            "app/assets/stylesheets/bootstrap_overrides/bootstrap_overrides.css.scss"
    end
    def copy_javascripts
      FileUtils.mkdir_p "public/javascripts/sylrplm_ext"
      copy_file "../../../app/assets/javascripts/sylrplm_extensions.js",        "public/javascripts/sylrplm_ext/sylrplm_extensions.js"
    end
  end
end
