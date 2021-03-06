Rails.application.routes.draw do

  resource :users, only: [:show]
  get '/users/stars', to: 'users#user_stars'
  get '/auth/github', to: 'authentication#github', format: false
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/issues/start', to: 'issues#start'
  get '/issues', to: 'issues#index'

  get '/issues/search', to: 'issues#results'
  get '/issues/:id', to: 'issues#show'

  post '/issues/search', to: 'issues#search'

  get '/user_feedbacks', to: 'user_feedbacks#all'
  post '/user_feedbacks', to: 'user_feedbacks#create'


  get '/graphqlexample', to: 'application#graphqlexample'

  post '/stars/create', to: 'stars#create'
  post '/stars/delete', to: 'stars#delete'
  get '/logout', to: 'authentication#logout', format: false


end
