class CreatePostVotes < ActiveRecord::Migration
  def change
    create_table :post_votes do |t|
      t.belongs_to :user
      t.belongs_to :post
      t.binary :value
    end
  end
end
