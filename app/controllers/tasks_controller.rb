class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks
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
      redirect_to @task, notice: "タスク「#{@task.title}」を登録しました"
    else
      render :new
    end
  end


  def edit
    # 共通化　set_taskメソッドに処理あり
  end

  def update
    # 共通化　set_taskメソッドに処理あり
    @task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{@task.title}」を更新しました"
  end

  def destroy
    # 目的のタスクをIDで検索する
    # 共通化　set_taskメソッドに処理あり
    # 削除する
    @task.destroy
    # 一覧ページに戻る
    redirect_to tasks_url, notice: "タスク「#{@task.title}」を削除しました"
  end



  private
  
  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  
  def task_params
    params.require(:task).permit(:title, :weight, :rep, :set_count, :memo, :deadline, :status)  
  end

end
