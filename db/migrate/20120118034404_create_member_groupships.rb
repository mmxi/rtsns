class CreateMemberGroupships < ActiveRecord::Migration
  def change
    create_table :member_groupships do |t|
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
  end
end
