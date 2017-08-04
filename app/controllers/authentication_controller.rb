  class AuthenticationController < ApplicationController
  def github
    authenticator = Authenticator.new
    user_info = authenticator.github(params[:code])

    login = user_info[:login]
    name = user_info[:name]
    email = user_info[:email]
    avatar_url = user_info[:avatar_url]
    html_url = user_info[:html_url]
    user_created_at = user_info[:user_created_at]
    public_repos = user_info[:public_repos]

    # Generate token...
    token = TokiToki.encode(login)
    # ... create user if it doesn't exist...
    User.where(login: login).first_or_create!(
      name: name,
      email: email,
      avatar_url: avatar_url,
      html_url: html_url,
      user_created_at: user_created_at,
      public_repos: public_repos
    )
    response.set_cookie 'token', {value: token, domain: 'opensores.herokuapp.com', path: "/"}
    response.set_cookie 'token', {value: token, domain: 'opensores-back.herokuapp.com', path: "/"}
    # ... and redirect to client app.
    # redirect_to "#{issuer}?token=#{token}"
    redirect_to "#{issuer}search"

  rescue StandardError => error
    redirect_to "#{issuer}?error=#{error.message}"
  end

  def logout
    response.delete_cookie 'token'
    redirect_to issuer
  end

  private

  def issuer
    ENV['CODESORES_CLIENT_URL']
  end
end
