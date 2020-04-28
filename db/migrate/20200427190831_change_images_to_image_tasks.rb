class ChangeImagesToImageTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :images, :image
  end
end
