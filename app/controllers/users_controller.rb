class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

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
      # @userが保存されていれば、ユーザ詳細画面に遷移し、メッセージを表示させる
      redirect_to user_path(@user), notice: 'ユーザー登録が完了しました！'
    else
      # 保存に失敗したら（パスワードの不一致など）新規登録画面を表示させる
      render :new, notice: 'ユーザー登録の失敗しました'
    end
  end



  # def create
  #   @user = User.new(user_params)

  #   respond_to do |format|
  #     if @user.save
  #       format.html { redirect_to @user, notice: 'User was successfully created.' }
  #       format.json { render :show, status: :created, location: @user }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

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

  # def update
  #   respond_to do |format|
  #     if @user.update(user_params)
  #       format.html { redirect_to @user, notice: 'User was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @user }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    # 共通化済み　set_user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end
end
