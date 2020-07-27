class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :login_required
  before_action :login_required
  

  private
  
  def current_user
    # @current_userがnilならUser.find_by(id: session[:user_id]) で
    # セッション情報ほ検索し、代入する
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  # ユーザーがログインしていないとき、ログインを要求する
  def login_required
    # 
    redirect_to login_url unless current_user
  end

end
