class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :question
      t.string :answer

      t.timestamps null: false
    end
  end
end
