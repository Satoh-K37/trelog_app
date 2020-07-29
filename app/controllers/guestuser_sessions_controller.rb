class GuestuserSessionsController < ApplicationController

  skip_before_action :login_required

  
  def create
    # 引数の条件に該当するデータがあればそれを返すfind_by(attributes)、なければ新規作成create(attributes, &block)
    @user = User.find_or_create_by(email: 'guest@example.com') do |user|
      # パスワードをランダムで生成する。GithubbにソースコードをあげるときにPWの漏洩が防げる。
      user.password = SecureRandom.urlsafe_base64
      # 作成したユーザーの名前
      user.user_name = "ゲストユーザー"
    end
    # ログインさせる
    auto_login(@user)
    redirect_to todo_tasks_path(@user), notice: 'ゲストユーザーでログインしました'
  end





  # def guest_login
  #   @user = User.find_or_create_by(email: 'guest@example.com') do |user|
  #     user.password = SecureRandom.urlsafe_base64
  #     user.user_name = "ゲストユーザー"
  #   end
  #   auto_login(@user)

  #   redirect_to todo_tasks_path(@user), notice: 'ゲストユーザーでログインしました'
  # end

end
