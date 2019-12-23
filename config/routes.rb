Rails.application.routes.draw do

  get '/' => 'application#home'
  post '/login' => 'sessions#login'
  post '/signup' => 'users#create'
  delete '/logout' => 'sessions#logout'
  get '/auth-check' => 'sessions#auth_check'
  get '/auth/github/callback' => 'sessions#github_callback'
  get '/auth/github/redirect' => 'sessions#github_redirect'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
