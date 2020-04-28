class AddImagesColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :images, :string
  end
end
