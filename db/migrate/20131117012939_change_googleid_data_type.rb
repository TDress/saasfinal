class ChangeGoogleidDataType < ActiveRecord::Migration
  def change
	add_column :users, :new_google_id, :integer

    User.reset_column_information
    User.all.each do |r|
       r.new_google_id = r.google_id
       r.save!
    end

    remove_column :users, :google_id
    rename_column :users, :new_google_id, :google_id
  end
end
