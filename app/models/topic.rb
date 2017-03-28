class Topic < ApplicationRecord

  validates_presence_of :title
  
  belongs_to :user, :optional => true

  has_many :likes, :dependent => :destroy
  has_many :liked_users, :through => :likes, :source => :user

  def find_like(user)
    Like.where( :topic_id => self.id, :user_id => user.id ).first
  end

  def is_liked_by(user)
    find_like(user).present?
  end

end
