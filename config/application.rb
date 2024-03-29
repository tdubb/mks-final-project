require File.expand_path('../boot', __FILE__)

require 'rails/all'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
# Bundler.require(:default, Rails.env)
# precompile assets
Bundler.require(*Rails.groups(assets: %w(development test)))

module C2g
  class Application < Rails::Application

    # Warn about missing configuration files
    %w[.env config/database.yml].reject do |file|
      File.exists? Rails.root.join(file)
    end.each do |missing_file|
      warn "Please configure '#{missing_file}'. See '#{missing_file}.example'"
    end if Rails.env.development?

    # don't generate RSpec tests for views and helpers
    config.generators do |g|

      g.test_framework :rspec, fixture: true

      # g.fixture_replacement :machinist
      g.controller_specs false
      g.view_specs false
      g.helper_specs false
    end

    I18n.enforce_available_locales = false

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/lib)

    # for background workers
    # config.autoload_paths += %W(#{config.root}/app/commands)

    console do
      load './spec/support/blueprints.rb'
      Hirb.enable
    end

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # config.assets.precompile += %w( bootsy.css bootsy.js upload_worker.js html5shiv.js ie9.css ie8.css ie7.css )

    # Must be enabled for JS-Routes to work
    config.assets.initialize_on_precompile = true
  end
end
