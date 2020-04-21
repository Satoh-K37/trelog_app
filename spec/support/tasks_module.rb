module TasksModule
  def create(task)
    visit new_task_path
    fill_in 'task_title', with: task_title
    fill_in 'weight', with: task_weight
    fill_in 'rep', with: task_rep
    fill_in 'set_count', with: task_set_count
    fill_in 'task_memo', with: task_memo
    click_button '登録'
    tasks_path
  end
end
