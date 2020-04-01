class UserSessionsController < ApplicationController
  skip_before_action :login_required
  def new
    @user = User.new
  end

  def create
    # ログイン画面で入力されたメールアドレスを引数にユーザを検索
    user = User.find_by(email: session_params[:email])
    # パスワードによる認証をauthenticateメソッドを使って行う
    if user&.authenticate(session_params[:password])
      # 認証に成功した場合、セッションにuser_idを格納
      session[:user_id] = user.id
      # ユーザ詳細画面に遷移
      redirect_to user_path(user.id), notice: 'ログインしました'
      # log_in user
      # redirect_to user
    else
      # ログインに失敗した場合はログイン画面を再表示させる
      flash.now[:alert] = 'PWかメールアドレスが違います'
      render :new
    end
  end

  def destroy
    # セッションに保存された情報を削除
    reset_session
    # ログイン画面に遷移する…多分。
    redirect_to login_path, notice: 'ログアウトしました'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end


end
