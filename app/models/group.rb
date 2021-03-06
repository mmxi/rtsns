class Group < ActiveRecord::Base
  belongs_to :creator, :class_name => 'User', :foreign_key => :user_id
  has_many :member_groupships, :dependent => :destroy
  has_many :members, :through => :member_groupships, :class_name => 'User', :source => :user
  
  mount_uploader :picture, GroupUploader
  
  validates_presence_of :title
  validates_uniqueness_of :title
  validates_presence_of :introduction
  
  attr_accessor :accessible
  
  before_save :update_members
  
  def update_members
    self.members_count = self.members.count
  end

  private
    def mass_assignment_authorizer(role = :default)
      if accessible == :all
        self.class.protected_attributes
      else
        super + (accessible || [])
      end
    end

end
