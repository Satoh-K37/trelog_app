class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :login_required
  before_action :login_required

  private
  
  def current_user
    # @current_userがnilならUser.find_by(id: session[:user_id]) でセッション情報ほ検索し、代入する
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # #   # URLを直打ちで別のユーザーを表示されるのを防ぐ
  # def correct_user
  
  #   @user = current_user.User.find_by(params[:id])
  #   redirect_to tasks_path if current_user != @user
  # end

  # ユーザーがログインしていないとき、ログインを要求する
  def login_required
    # 
    redirect_to login_url unless current_user
  end

end
