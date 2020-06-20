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
  # get '/users/:id' => 'users#show', as: 'mypage'
  resources :users, only: %i[create edit update show index destroy]
  resources :password_resets, only: %i[new create edit update]
  ####################

  root to: 'tasks#index'
  # タスク機能関係
  resources :tasks do
    collection do
      get :todo, :done
      # Ajaxでタスクのステータスを切り替える
      post '/:id/task_status' => 'tasks#task_status', as: 'status'
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