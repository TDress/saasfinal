class FixDateCreated < ActiveRecord::Migration
  def change
	rename_column :posts, :date_created, :created_on
	change_column :posts, :created_on, :date
  end
end
