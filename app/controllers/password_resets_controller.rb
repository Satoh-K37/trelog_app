class PasswordResetsController < ApplicationController
    skip_before_action :login_required

  # パスワード再発行申請用のファームアクション
  def new
  end

  # パスワードリセットをリクエストするアクション
  # パスワードリセットのフォームに情報が入力されて送信されるとこのアクションが実行される
  def create
    # フォームから送られてきたemailをparamsで受け取る
    @user = User.find_by_email(params[:email])
    # DBからデータを受け取れていれば、パスワード再設定用のURLを表示させる
    @user.deliver_reset_password_instructions! if @user
    redirect_to(login_path, :notice => '入力されたメールアドレスに再設定用のURLを送信しました。')

  end

    # パスワードリセットフォームページへ遷移するアクション
  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end
  end

  # ユーザーがパスワードのリセットフォームを送信(新しいパスワードの入力)したときに実行される
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
      # Welcomページに遷移する
      redirect_to(home_path, :notice => 'パスワードを変更しました。')
    else
      render :action => "edit"
    end
  end

end
