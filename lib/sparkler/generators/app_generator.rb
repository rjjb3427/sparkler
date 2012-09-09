require 'rails/generators'
require 'rails/generators/rails/app/app_generator'

module Sparkler
  class AppGenerator < Rails::Generators::AppGenerator

    def finish_template
      invoke :sparkler_customization
      super
    end

    def sparkler_customization
      invoke :remove_useless_files
    end

    def remove_useless_files
      build :remove_public_index
      build :remove_rails_logo_image
    end

    def setup_staging_environment
      say 'Setting up the staging environment'
      build :setup_staging_environment
      build :initialize_on_precompile
    end

    def run_bundle

    end

    protected

    def get_builder_class
      Sparkler::AppBuilder
    end

    def using_active_record?
      !options[:skip_active_record]
    end
  end
end

