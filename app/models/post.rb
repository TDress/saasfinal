# This class defines the post model, has a belongs_to association with 
# the user model, and a has_many association with post_votes and
# post_comments
class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_votes 
  has_many :post_comments
  
  validates :title, :presence => true
  validates :user_id, :presence => true
  validates :content, :presence => true
  validates :created_on, :presence => true
end
