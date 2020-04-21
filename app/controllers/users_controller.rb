class UsersController < ApplicationController
  skip_before_action :login_required 
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  # GET /users
  # GET /users.json
  def index
    # @users = User.all
    # @q  =  .ransack(params [:q])
    # @users  =  @q .result.(distinct: true).recent
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  # 検索
  # def search
  #   if params[:user_name].present?
  #     @users = User.where('user_name LIKE ?', "%#{params[:user_name]}%")
  #   else
  #     @users = User.none
  #   end
  # end


  # GET /users/1
  # GET /users/1.json
  def show
    # 共通化済み　set_user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    # 共通化済み　set_user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      # ここでメールが送信される
      # UserMailer.send_message_to_user(@user.user).deliver_now
      # ログインさせる
      log_in @user
      # @userが保存されていれば、ユーザ詳細画面に遷移し、メッセージを表示させる
      redirect_to tasks_path, notice: 'ユーザー登録が完了しました！'
    else
      # 保存に失敗したら（パスワードの不一致など）新規登録画面を表示させる
      render :new
      # notice: 'ユーザー登録の失敗しました'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    # 対象のユーザーをidで検索して、@userに格納
    # 共通化済み　set_user
    #　user_paramsの値に変更があった場合にifの処理に入る。それ以外はelseに入る。
    if @user.update(user_params)
      # 更新に成功したら、ユーザー詳細ページに遷移する
      redirect_to user_path(@user), notice: '更新しました'
    else
      # 更新に失敗した場合は再度、編集のページを表示させる
      render :edit
    end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    # 共通化済み　set_user
    @user.destroy
    redirect_to users_url notice: "ユーザー「#{@user.user_name}」を削除しました。"
    end
  end

  private
  
  def log_in(user)
    session[:user_id] = user.id
  end

  #ユーザ検索の共通化の処理に使ってる
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end