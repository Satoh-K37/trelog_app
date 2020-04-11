class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    # IDで目的のタスクを検索
    @task = Task.find(params[:id])
  end

  def new
    # 新しいTaskオブジェクトを生成して、@taskに代入
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: "タスク「#{@task.title}」を登録しました"
    else
      render :new
    end
  end


  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.title}」を更新しました"
  end

  def destroy
    # 目的のタスクをIDで検索する
    task = Task.find(params[:id])
    # 削除する
    task.destroy
    # 一覧ページに戻る
    redirect_to tasks_url, notice: "タスク「#{task.title}」を削除しました"
  end



  private
  
  def task_params
    params.require(:task).permit(:title, :weight, :rep, :set_count, :memo, :deadline, :status)  
  end

end
