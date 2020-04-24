class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :if_not_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @q = User.ransack(params[:q])
    # 検索フォームに入力された値を含むユーザー一覧を表示させる
    @users = @q.result(distinct: true)
  end

  def show
    # 共通化済み　set_user
  end

  def new
    @user = User.new
  end

  def edit
    # 共通化済み　set_user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path(@user), notice: '管理者がユーザーを登録しました'
    else
      # 保存に失敗したら（パスワードの不一致など）新規登録画面を表示させる
      render :new
    end
  end

  def update
    # 対象のユーザーをidで検索して、@userに格納
    # 共通化済み　set_user
    #　user_paramsの値に変更があった場合にifの処理に入る。それ以外はelseに入る。
    if @user.update(user_params)
      # 更新に成功したら、ユーザー詳細ページに遷移する
      redirect_to admin_users_path(@user), notice: "「#{@user.user_name}」更新しました"
      
    else
      # 更新に失敗した場合は再度、編集のページを表示させる
      render :edit
    end
  end
  

  def destroy
    # 共通化済み　set_user
    @user.destroy
    redirect_to admin_users_url notice: "「#{@user.user_name}」を削除しました。"
    end
  end



  private
  # 管理ユーザー以外で特定のアクションを実行しようとした場合はタスク一覧ページににリダイレクトさせる。
  def if_not_admin
    redirect_to tasks_path unless current_user.admin?
  end

  #ユーザ検索の共通化の処理に使ってる
  def set_user
    @user = User.find(params[:id])
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :icon_image, :admin, :password, :password_confirmation)
  end
