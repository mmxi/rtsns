class AddNameAndAvatarToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_column :users, :avatar, :string
  end
  
  def self.down
    remove_column :users, :name
    remove_column :users, :avatar
  end
end