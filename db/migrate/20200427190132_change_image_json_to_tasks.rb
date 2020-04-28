class ChangeImageJsonToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :images, :string
  end
end
