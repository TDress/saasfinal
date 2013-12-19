class AddVoteSumToPost < ActiveRecord::Migration
  def change
    add_column :posts, :vote_sum, :integer, :default => 0
  end
end
