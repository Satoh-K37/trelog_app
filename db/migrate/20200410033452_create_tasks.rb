class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :weight
      t.integer :rep
      t.integer :set_count
      t.text :memo
      t.date :deadline
      t.integer :status

      t.timestamps
    end
  end
end
