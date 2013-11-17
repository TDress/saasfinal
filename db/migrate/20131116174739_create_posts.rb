class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user
      t.timestamp :date_created
      t.text :content
      t.string :title
    end
  end
end
