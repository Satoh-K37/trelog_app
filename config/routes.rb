Rails.application.routes.draw do
  get '/login' => 'user_sessions#new'
  post '/login' => 'user_sessions#create'
  delete '/logout' => 'user_sessions#destroy'

  get '/signup' => 'users#new'
  resources :users
  resources :password_resets, only: %i[new create edit update]
  
  # LetterOpenerWebアクセスする
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
