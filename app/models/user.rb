class User < ActiveRecord::Base
  has_many :posts
  has_many :post_comments
  validates :linkedin_id, uniqueness: true
  validates :email, uniqueness: true
end
