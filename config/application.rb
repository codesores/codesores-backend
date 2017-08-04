require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"

require "graphql/client/railtie"
require "graphql/client/http"

# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CodesoresBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.eager_load_paths << Rails.root.join('lib')
    
    config.autoload_paths += %W(#{config.root}/lib)


    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins ENV["CODESORES_CLIENT_URL"]
        resource '*', :headers => :any, :methods => [:get, :post, :delete, :put, :patch, :options, :head]
      end
    end
  end

    HTTPAdapter = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
      def headers(context)
        unless token = context[:access_token] || Application.secrets.github_access_token
          # $ GITHUB_ACCESS_TOKEN=abc123 bin/rails server
          #   https://help.github.com/articles/creating-an-access-token-for-command-line-use
          fail "Missing GitHub access token"
        end

        {
          "Authorization" => "Bearer #{token}"
        }
      end
    end

    Client = GraphQL::Client.new(
      schema: Application.root.join("db/github_schema.json").to_s,
      execute: HTTPAdapter
    )

    Application.config.graphql.client = Client


end
