class PasswordResetsController < ApplicationController
    skip_before_action :login_required

  def new
  end

  # パスワードリセットのフォームに情報が入力されて送信されるとこのアクションが実行される
  def create
    @user = User.find_by_email(params[:email])
    # パスワード再設定用のURLを表示させる
    @user.deliver_reset_password_instructions! if @user
    redirect_to(login_path, :notice => '入力されたメールアドレスに再設定用のURLを送信しました。')

  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    # パスワードの検証を行う
    @user.password_confirmation = params[:user][:password_confirmation]
    # トークンを削除し、パスワードを更新する
    if @user.change_password!(params[:user][:password])
      redirect_to(root_path, :notice => 'パスワードが更新しました。')
    else
      render :action => "edit"
    end
  end
end
