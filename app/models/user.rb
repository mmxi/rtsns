class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :avatar
  has_many :authorizations, :dependent => :destroy
  has_many :groups
  has_many :member_groupships, :dependent => :destroy
  has_many :member_of, :through => :member_groupships, :class_name => 'Group', :source => :group
  mount_uploader :avatar, AvatarUploader
  
  def update_with_password(params={})
    if !params[:current_password].blank? or !params[:password].blank? or !params[:password_confirmation].blank?
      super
    else
      params.delete(:current_password)
      self.update_without_password(params)
    end
  end
        
  def is_creator_of?(group)
    self.groups.include?(group)
  end
  
  def is_member_of?(group)
    self.member_of.include?(group)
  end

  def become_member_of(group)
    if group.allowadduser and group.verified and !self.is_member_of?(group) and !self.is_creator_of?(group)
      group.members << self
      group.save!
    end
  end

  def leave(group)
    if self.is_member_of?(group) and !self.is_creator_of?(group)
      self.member_of.delete(group) if self.is_member_of?(group)
      group.save!
    end
  end
  
end
