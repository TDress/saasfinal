class ChangePostCreatedOnToDateTime < ActiveRecord::Migration
  def change
    change_column :posts, :created_on, :datetime
  end
end
