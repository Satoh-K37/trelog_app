class UserSessionsController < ApplicationController
  skip_before_action :login_required
  def new
    @user = User.new
  end

  def create
    if @user = login(session_params[:email], session_params[:password], session_params[:remember])
      # ユーザ詳細画面に遷移
      redirect_to user_path(@user), notice: 'ログインしました'
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
    params.require(:session).permit(:email, :password, :remember)
  end


end
