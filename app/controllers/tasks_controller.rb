class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update,:destroy]
  

  def index
    @q = current_user.tasks.ransack(params[:q])
    # 検索フォームに入力された値を含むユーザー一覧を表示させる
    @tasks = @q.result(distinct: true)

    # @show = params[:show] 
    
    # if @show == '1' then
    #   @tasks = Task.where(status: 1)
    # elsif @show == "2"
    #   @tasks = Task.where(status: 2)
    # else
    #   @tasks = Task.all
    # end

  end

  def todo
    # 未完了
    @q = current_user.tasks.where(status: false).ransack(params[:q])
    # 検索フォームに入力された値を含むユーザー一覧を表示させる
    @tasks = @q.result(distinct: true)
    end
    
    def done
    # 完了
    @q = current_user.tasks.where(status: true).ransack(params[:q])
    # 検索フォームに入力された値を含むユーザー一覧を表示させる
    @tasks = @q.result(distinct: true)
    end


  def show
    # IDで目的のタスクを検索
    # 共通化　set_taskメソッドに処理あり
  end

  def new
    # 新しいTaskオブジェクトを生成して、@taskに代入
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to todo_tasks_path, notice: "タスク「#{@task.title}」を登録しました"
      # redirect_to @task, notice: "タスク「#{@task.title}」を登録しました"
    else
      render :new
    end
  end


  def edit
    # 共通化　set_taskメソッドに処理あり
  end

  def update
    # 共通化　set_taskメソッドに処理あり
    if @task.update(task_params)
      redirect_to todo_tasks_url, notice: "タスク「#{@task.title}」を更新しました"
    else
      render :edit
    # タスクの変更に失敗すると編集画面に戻るようにしたい…
    end
  end

  # def done
  #   @task.update(status: 1)
  #   @tasks = Task.all
  #   # .includes(:user)
  #   # render :index
  # end



  def destroy
    # 目的のタスクをIDで検索する
    # 共通化　set_taskメソッドに処理あり
    # 削除する
    @task.destroy
    # Ajaxでタスクを削除できるようにした。
    head :no_content, notice: "タスク「#{@task.title}」を削除しました"
    # 一覧ページに戻る
    # redirect_to tasks_url, notice: "タスク「#{@task.title}」を削除しました"
  end



  private
  
  def set_task
    @task = current_user.tasks.find(params[:id])
  end


  
  def task_params
    params.require(:task).permit(:title, :weight, :rep, :set_count, :deadline, :status, :memo, :image, :image_cache)  
  end



end
