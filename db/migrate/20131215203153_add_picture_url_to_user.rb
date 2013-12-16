class AddPictureUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_picture_url, :string, :default => "/assets/no-image.png"
  end
end
