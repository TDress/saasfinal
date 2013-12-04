class ChangeLinkedinIdBackToString < ActiveRecord::Migration
  def change
    add_column :users, :new_linkedin_id, :string

    User.reset_column_information
    User.all.each do |r|
      r.new_linkedin_id = r.linkedin_id
      r.save!
    end

    remove_column :users, :linkedin_id
    rename_column :users, :new_linkedin_id, :linkedin_id
  end
end
