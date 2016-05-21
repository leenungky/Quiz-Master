class AddColumnWordToQuestion < ActiveRecord::Migration
  def change
	add_column :questions, :words, :string
  end
  
     
  def down
    remove_column :questions, :words    
  end
end
