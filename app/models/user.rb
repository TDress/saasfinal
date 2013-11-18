class User < ActiveRecord::Base
  has_many :posts
  #has_many :comments, through: :posts
  validates :linkedin_id, uniqueness: true
  validates :email, uniqueness: true
end
