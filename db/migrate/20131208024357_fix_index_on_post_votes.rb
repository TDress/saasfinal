class FixIndexOnPostVotes < ActiveRecord::Migration
  def change
    remove_index :post_votes, :user_id
    add_index :post_votes, [:post_id, :user_id], :unique => true
  end
end
