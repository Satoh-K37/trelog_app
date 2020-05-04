Rails.application.routes.draw do
  # ログインせずに見れるページ
  get '/home' => 'static_pages#home'
  get '/about' => 'static_pages#about'
  ####################
  
  # ユーザ周り
  get '/login' => 'user_sessions#new'
  post '/login' => 'user_sessions#create'
  delete '/logout' => 'user_sessions#destroy'
  
  get '/signup' => 'users#new'
  resources :users, only: %i[create edit update show index destroy] 
  resources :password_resets, only: %i[new create edit update]
  ####################

  # タスク機能関係
  resources :tasks do
    collection do
      get :todo, :done
      # Ajaxでタスクのステータスを切り替えるためのルート
      post '/:id/task_status' => 'tasks#task_status'
    end
  end
  
  ####################

  # 管理者
  namespace :admin do
    resources :users, only: %i[new create edit update show index destroy]
  end
  ############################
  
  # LetterOpenerWebアクセスする
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end