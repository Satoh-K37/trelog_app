class ChangeIntegerToStutasToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :status, false, false
    change_column :tasks, :status, :boolean
  end
end
