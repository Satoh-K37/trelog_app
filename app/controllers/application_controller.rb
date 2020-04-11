class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required

  private
  
  def current_user
    # @current_userがnilならUser.find_by(id: session[:user_id]) でセッション情報ほ検索し、代入する
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # ユーザーがログインしていないとき、ログインを要求する
  def login_required
    # login_required
    redirect_to login_url unless current_user
  end

end
