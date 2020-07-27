class GuestuserSessionsController < ApplicationController
  # before_action :guest_login, onry: [:create]
  # # def guest_login
  skip_before_action :login_required

  # # end
  # def create
  #   # guest_user = User.find_by(email: "test@gmail.com")
  #   # auto_login(guest_user)
  #   # flash[:success] ='テストユーザーでログインしました。'
  #   # redirect_to todo_tasks_path(user)
  # end
  def guest_login
    @user = User.find_or_create_by(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.user_name = "ゲストユーザー"
    end
    auto_login(@user)

    redirect_to todo_tasks_path(@user), notice: 'ゲストユーザーでログインしました'
  end


end
