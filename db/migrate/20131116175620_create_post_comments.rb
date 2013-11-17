class CreatePostComments < ActiveRecord::Migration
  def change
    create_table :post_comments do |t|
	  t.belongs_to :user
	  t.belongs_to :post
      t.text :content
    end
  end
end
