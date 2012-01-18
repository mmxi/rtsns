class Group < ActiveRecord::Base
  belongs_to :user
  has_many :member_groupships
  has_many :members, :through => :member_groupships, :class_name => 'User', :source => :user
  
  before_save :update_members
  
  def update_members
    self.members_count = self.members.size
  end
  
end
