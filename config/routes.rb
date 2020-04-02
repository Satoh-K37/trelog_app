Rails.application.routes.draw do
  get '/login' => 'user_sessions#new'
  post '/login' => 'user_sessions#create'
  delete '/logout' => 'user_sessions#destroy'

  get '/signup' => 'users#new'
  resources :users
end
