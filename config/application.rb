require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module GkoVillaMicalao
  class Application < Rails::Application 
    require 'rack/rewrite'
     
    config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
      r301 '/amenagements-location-villast-barth.asp?id_pa=4856', '/amenagements-et-equipements'
      r301 '/facilities-luxury-villa-st-barts.asp?id_pa=5287', '/en/facilities-appliances-and-fittings'
      r301 '/tarifs-location-villa-st-barthelemy.asp?id_pa=4955', '/tarifs-location-saisonniere'
      r301 '/rental-rates-for-micalao-villa-st-barts.asp?id_pa=5288', '/en/weekly-rental-rates'
      r301 '/galerie-photos.asp?id_pa=4853', '/galerie-photos/villa'
      r301 '/gallery-villa-micalao.asp?id_pa=5285', '/en/villa-photo-gallery'
      r301 '/micalao-et-st-barth.asp?id_pa=4857', '/nous-et-saint-barth'
      r301 '/micalao-and-st-barts.asp?id_pa=5289', '/en/us-and-st-barts'
      r301 '/services-location-st-barth.asp?id_pa=4954', '/nos-services'
      r301 '/extra-services-villa-st-barth.asp?id_pa=5290', '/en/services'
      r301 '/formulaire.asp?ifo=361&id_pa=4852', '/contact'
      r301 '/formulaire.asp?ifo=414&id_pa=4852', '/en/contact'
      r301 '/livre-dor-micalao-st-barth.asp?id_pa=5125', ''
      r301 '/guest-book-micalao-st-barts.asp?id_pa=5286', ''		
      r301 '/mentions_legales.asp?id_pa=-1', '/mentions-legales'
      r301 '/insiders-location-st-barthelemy.asp?id_pa=4956', '/les-insiders'
      r301 '/inside-guides-st-barts.asp?id_pa=5291', '/insiders-guide'	
    end
    
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
  end
end
