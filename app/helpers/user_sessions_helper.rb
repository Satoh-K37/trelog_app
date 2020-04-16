module UserSessionsHelper
  
  # # 渡されたユーザーでログインする
  # def log_in(user)
  #   session[:user_id] = user.id
  # end

  #       #ユーザ検索の共通化の処理に使ってる
  # def set_user
  #   @user = User.find(params[:id])
  # end

  # def current_user
  #   if session[:user_id].present?
  #     @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  #   end
  # end

end
