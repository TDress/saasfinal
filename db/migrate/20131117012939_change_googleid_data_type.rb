class ChangeGoogleidDataType < ActiveRecord::Migration
  def change
	change_column :users, :google_id, :integer
  end
end
