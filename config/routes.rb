Rails.application.routes.draw do
  resource :user, only: [:show]
  get '/auth/github', to: 'authentication#github', format: false
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/issues/start', to: 'issues#start'
  get '/issues', to: 'issues#index'
  
  get '/issues/search', to: 'issues#results'
  get '/issues/:id', to: 'issues#show'

  post '/issues/search', to: 'issues#search'

end
