class ChangeImagesStringToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :images, :json
  end
end
