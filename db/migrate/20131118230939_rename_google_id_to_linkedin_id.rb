class RenameGoogleIdToLinkedinId < ActiveRecord::Migration
  def change
    rename_column :users, :google_id, :linkedin_id
    add_index :users, :linkedin_id, unique: true
  end
end
