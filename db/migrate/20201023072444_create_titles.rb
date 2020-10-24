class CreateTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :titles do |t|
      t.string :title_name, null: false

      t.timestamps
    end
  end
end
