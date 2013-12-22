module Sparkler
  class AppBuilder < Rails::AppBuilder
    include Sparkler::Actions

    def remove_public_index
      remove_file 'public/index.html'
    end

    def remove_rails_logo_image
      remove_file 'app/assets/images/rails.png'
    end

    def use_coffeescript
      remove_file 'app/assets/javascripts/application.js'
      directory 'javascripts', 'app/assets/javascripts'
    end

    def setup_staging_environment
      run 'cp config/environments/production.rb config/environments/staging.rb'
    end

    def create_partials_directory
      empty_directory 'app/views/application'
    end

    def create_shared_flashes
      copy_file '_flashes.html.haml', 'app/views/application/_flashes.html.haml'
    end

    def create_application_layout
      remove_file 'app/views/layouts/application.html.erb'
      copy_file 'application_layout.html.haml', 'app/views/layouts/application.html.haml', force: true
    end

    def gemfile
      remove_file 'Gemfile'
      copy_file 'Gemfile.new', 'Gemfile'
    end

    def use_sqlite_config_template
      template 'database.sqlite.yml.erb', 'config/database.yml', force: true
      template 'database.sqlite.yml.erb', 'config/database.example.yml', force: true
    end

    def use_postgres_config_template
      template 'database.postgres.yml.erb', 'config/database.yml', force: true
      template 'database.postgres.yml.erb', 'config/database.example.yml', force: true
    end

    def setup_local_postgres
      run 'initdb pg'
    end

    def ignore_local_postgres
      append_file '.git/info/exclude', '/pg/'
    end

    def create_postgres_database
      pid = fork { exec 'postgres', '-D', 'pg' }
      bundle_command 'exec rake db:create'
      Process.kill "INT", pid
    end

    def create_sqlite_database
      bundle_command 'exec rake db:create'
    end

    def setup_gitignore
      gitignore_file = find_in_source_paths('gitignore_additions')
      gitignore = File.open(gitignore_file).read
      append_file '.gitignore', gitignore
    end

    def init_git
      run 'git init'
    end

    def copy_miscellaneous_files
      copy_file 'time_formats.rb', 'config/initializers/time_formats.rb'
      template 'Procfile', 'Procfile'
    end

    def setup_high_voltage
      empty_directory 'app/views/pages'
      copy_file 'home.html.haml', 'app/views/pages/home.html.haml'
      route "root to: 'high_voltage/pages#show', id: 'home'"
    end

    def setup_foundation
      generate 'foundation:install --skip'
    end

    def add_foundation_to_application
      remove_file 'app/assets/stylesheets/application.css'
      copy_file 'application.css.sass', 'app/assets/stylesheets/application.css.sass'
    end

    def add_env_from_template
      copy_file 'env', '.env'
    end

    def setup_sentry
      copy_file 'raven.rb', 'config/initializers/raven.rb'
    end

    def setup_scripts
      %w(bootstrap data).each do |file|
        copy_file file, "script/#{file}"
        chmod "script/#{file}", 0755
      end
    end

    def remove_routes_comment_lines
      replace_in_file 'config/routes.rb', /Application\.routes\.draw do.*end/m, "Application.routes.draw do\nend"
    end

    def configure_generators
      generators_config = <<-RUBY.gsub(/^   {2}/, '')
        config.generators do |generate|
          generate.helper              false
          generate.assets              false
          generate.view_specs          false
        end\n
      RUBY
      inject_into_class 'config/application.rb', 'Application', generators_config
    end

    def configure_rspec
      inject_into_file 'config/application.rb', "      generate.test_framework      :rspec\n", after: "config.generators do |generate|\n"
      generate 'rspec:install'
    end
  end
end
