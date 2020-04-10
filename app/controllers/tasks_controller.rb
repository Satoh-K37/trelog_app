class TasksController < ApplicationController
  def index
  end

  def show
  end

  def new
    # 新しいTaskオブジェクトを生成して、@taskに代入
    @task = Task.new
  end

  def create
    task = Task.new(task_params)
    task.save!
    redirect_to tasks_url, notice: "タスク「#{task.title}」を登録しました"
  end


  def edit
  end

  private
  
  def task_params
    params.require(:task).permit(:title, :weight, :rep, :set_count, :memo, :deadline, :status)  
  end

end
