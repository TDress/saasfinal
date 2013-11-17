class CreatePostTags < ActiveRecord::Migration
  def change
    create_table :post_tags do |t|
      t.belongs_to :post
      t.string :tag
    end
  end
end
