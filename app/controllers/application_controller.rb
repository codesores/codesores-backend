class ApplicationController < ActionController::API
  class QueryError < StandardError; end
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


  IndexQuery = GitHub::Client.parse <<-'GRAPHQL'
    # All read requests are defined in a "query" operation
    query {
      # viewer is the currently authenticated User
      viewer {
        # "...FooConstant" is the fragment spread syntax to include the index
        # view's fragment.
        #
        # "Views::Repositories::Index::Viewer" means the fragment is defined
        # in app/views/repositories/index.html.erb and named Viewer.
        ...Views::Repositories::Index::Viewer
      }
    }
  GRAPHQL


  def index
    # data = query IndexQuery
    # p data
    render json: IndexQuery
  end

  private
    # Public: Define request scoped helper method for making GraphQL queries.
    #
    # Examples
    #
    #   data = query(ViewerQuery)
    #   data.viewer.login #=> "josh"
    #
    # definition - A query or mutation operation GraphQL::Client::Definition.
    #              Client.parse("query { version }") returns a definition.
    # variables - Optional set of variables to use during the operation.
    #             (default: {})
    #
    # Returns a structured query result or raises if the request failed.
    def query(definition, variables = {})
      response = GitHub::Client.query(definition, variables: variables, context: client_context)

      if response.errors.any?
        raise QueryError.new(response.errors[:data].join(", "))
      else
        response.data
      end
    end

    # Public: Useful helper method for tracking GraphQL context data to pass
    # along to the network adapter.
    def client_context
      # Use static access token from environment. However, here we have access
      # to the current request so we could configure the token to be retrieved
      # from a session cookie.
      { access_token: GitHub::Application.secrets.github_access_token }
    end
end
