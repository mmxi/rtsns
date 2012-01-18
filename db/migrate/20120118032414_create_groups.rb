class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title
      t.string :introduction
      t.boolean :verified, :default => false
      t.boolean :allowadduser, :default => true
      t.string :picture
      t.integer :members_count, :default => 0
      t.integer :user_id
      t.timestamps
    end
    
    add_index :groups, :user_id
    add_index :groups, :members_count
  end
end
