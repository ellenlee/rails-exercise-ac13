class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :topics

  has_many :likes, :dependent => :destroy
  has_many :liked_topics, :through => :likes, :source => :topic

  has_many :orders
  
  def display_name
    email.split("@").first
  end

  def is_admin?
    self.role == "admin"
  end

end
