Rails.application.routes.draw do
  resources :users
  get '/auth/github', to: 'authentication#github', format: false
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/issues', to: 'issues#index'
  get '/issues/:id', to: 'issues#show'

  post '/issues/search', to: 'issues#search'
  get '/issues/search', to: 'issues#results'

end