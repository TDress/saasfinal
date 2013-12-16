class AddCreatedOnToPostComment < ActiveRecord::Migration
  def change
    add_column :post_comments, :created_on, :datetime
    add_index :post_comments, :post_id
  end
end
