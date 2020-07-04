module TasksHelper
  require 'date'

  def deadline_count(task)
    # 現在の日付を取得し、変数に代入
    today = Date.today
    # 期限日を変数に代入する
    deadline = task.deadline
    # 期限日 - 現在の日付を計算してタスク終了期限日までの日数を割り出す。
    # 期限日 + 現在の日時を計算してタスク終了後に警告をだす

    # 期限日の値が入っているかを確認し、入っていなかったら直下の処理に入る
    if deadline.nil?
      "期限日: "
    # 期限日の値が入っている場合は下記の処理を実行する
    else
      deadline_alert = (deadline - today).numerator
          # 期限日と現在の日付に差がない場合
      if deadline_alert == 0
        "今日が期限日のタスクです"
        # 期限日が残り1〜３日になった場合
        # 期限日がすぎてからアラートを出すようにしたい。
      elsif deadline_alert.between?(1, 3)
        "期限日まで残り#{deadline_alert}日"
        # それ以外の場合
      else
        "期限日: #{task.deadline}"
      end
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
    
end
