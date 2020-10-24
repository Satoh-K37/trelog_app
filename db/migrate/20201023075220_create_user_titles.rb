class CreateUserTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_titles do |t|
      t.integer :users_id
      t.integer :titles_id

      t.timestamps
    end
  end
end
