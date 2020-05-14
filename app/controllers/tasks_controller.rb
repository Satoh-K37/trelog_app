class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update,:destroy, :task_status]
  

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
  
  # タスクのステータスを更新させる処理（Ajaxアクション）
  def task_status
    # 対処のタスクの検索はset_taskで共通化済み
    if @task.status == true
      @task.update(status: 'done')
      redirect_to done_tasks_path, notice: "タスク「#{@task.title}」を未完了にします"
    else
      @task.update(status: 'status')
      redirect_to todo_tasks_path, notice: "タスク「#{@task.title}」を完了しました"
    end
  end

  
  # プログレスバーで当日のタスクの進捗率を割り出すためのメソッド。
  # 忘れないようにメモ。あくまで案なので実際にやってみないとわからん
  def task_progress
    # １、当日に作成されたタスクを探して変数today_taskに代入(当日の判定の部分がまだ曖昧。ここ考える)
    # ２、当日のタスクの中でステータスが完了になっているものを変数done_taskに代入
    # ３、progress_result = today_task % done_task
    # ４、progress_resultをreturnで返す。
    # ５、viewでtask_progressを呼び出すとprogress_resultの値がくるはずなので、
    #    それをプログレスバーのvalueとして使えばタスク進捗率が出来上がるはず
    # 
  end





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
