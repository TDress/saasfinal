class ChangeVoteValueToInteger < ActiveRecord::Migration
  def change
    add_column :post_votes, :new_value, :integer

    PostVote.reset_column_information
    PostVote.all.each do |r|
      r.new_value = r.value
      r.save!
    end

    remove_column :post_votes, :value
    rename_column :post_votes, :new_value, :value

    add_index :post_votes, :user_id, unique: true
  end
end
