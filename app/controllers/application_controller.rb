class ApplicationController < ActionController::API
  class QueryError < StandardError; end
  require_relative '../../db/graphql_calls'

  def current_user
    token = params[:token]
    payload = TokiToki.decode(token)
    @current_user ||= User.find_by_login(payload[0]['sub'])
  end

  def logged_in?
    current_user != nil
  end

  def authenticate_user!
    head :unauthorized unless logged_in?
  end

  def graphqlexample
    data = CodesoresBackend::Client.parse GraphQLCalls::Login
    info = query data
    render json: info
  end

  private
    def query(definition, variables = {})
      response = CodesoresBackend::Client.query(definition, variables: variables, context: client_context)

      if response.errors.any?
        raise QueryError.new(response.errors[:data].join(", "))
      else
        response.data
      end
    end

    def client_context
      { access_token: CodesoresBackend::Application.secrets.github_access_token }
    end
end
