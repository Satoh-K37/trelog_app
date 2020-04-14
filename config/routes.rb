Rails.application.routes.draw do
  get '/home' => 'static_pages#home'
  get '/about' => 'static_pages#about'
  
  # ユーザ認証周り
  get '/login' => 'user_sessions#new'
  post '/login' => 'user_sessions#create'
  delete '/logout' => 'user_sessions#destroy'
  get '/signup' => 'users#new'
  resources :users
  resources :password_resets, only: %i[new create edit update]

  # タスク機能関係
  resources :tasks
  
  
  
  # LetterOpenerWebアクセスする
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
