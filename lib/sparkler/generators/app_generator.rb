require 'rails/generators'
require 'rails/generators/rails/app/app_generator'

module Sparkler
  class AppGenerator < Rails::Generators::AppGenerator
    class_option :skip_test_unit, type: :boolean, aliases: '-T', default: true, desc: 'Skip Test::Unit files'
    class_option :database, type: :string, aliases: '-d', default: 'sqlite3', desc: "Preconfigure for selected database (options: #{DATABASES.join('/')})"
    class_option :local_database, type: :boolean, aliases: '-D', default: false, desc: "Create a pg folder in the application"

    def finish_template
      invoke :sparkler_customization
      super
    end

    def sparkler_customization
      invoke :configure_generators
      invoke :customize_gemfile
      invoke :setup_database
      invoke :remove_useless_files
      invoke :remove_routes_comment_lines
      invoke :setup_staging_environment
      invoke :create_views_and_layouts
      invoke :copy_miscellaneous_files
      invoke :setup_foundation
      invoke :use_coffeescript
      invoke :setup_sentry
      invoke :setup_env
      invoke :setup_rspec
      invoke :setup_git
      invoke :setup_scripts
    end

    def use_coffeescript
      build :use_coffeescript
    end

    def remove_useless_files
      build :remove_public_index
      build :remove_rails_logo_image
    end

    def setup_database
      if options[:database] == 'postgresql'
        build :use_postgres_config_template
        build :setup_local_postgres if options[:local_database]
        build :create_postgres_database
      elsif options[:database] == 'sqlite3'
        build :use_sqlite_config_template
        build :create_sqlite_database
      end
    end

    def setup_staging_environment
      say 'Setting up the staging environment'
      build :setup_staging_environment
    end

    def create_views_and_layouts
      say 'Creating layouts and partials'
      build :create_partials_directory
      build :create_shared_flashes

      say 'Setting up High Voltage and a home page'
      build :setup_high_voltage
    end

    def setup_foundation
      say 'Generating Foundation'
      build :setup_foundation
      build :add_foundation_to_application
      build :create_application_layout
    end

    def setup_sentry
      say 'Configuring Sentry'
      build :setup_sentry
    end

    def customize_gemfile
      say 'Setting up gems and bundling'
      build :gemfile
      bundle_command 'install --path vendor'
      bundle_command 'package'
    end

    def configure_generators
      say 'Configuring generators'
      build :configure_generators
    end

    def setup_git
      say 'Initalizing git repo'
      build :setup_gitignore
      build :init_git
      build :ignore_local_postgres if options[:local_database]
    end

    def setup_scripts
      say 'Adding convenience scripts'
      build :setup_scripts
    end

    def copy_miscellaneous_files
      say 'Copying miscellaneous support files'
      build :copy_miscellaneous_files
    end

    def setup_env
      say 'Adding an .env file'
      build :add_env_from_template
    end

    def setup_rspec
      say 'Configuring Rspec'
      build :configure_rspec
    end

    def remove_routes_comment_lines
      build :remove_routes_comment_lines
    end

    def outro
      say 'Congratulations! Your app is ready to go!'
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

