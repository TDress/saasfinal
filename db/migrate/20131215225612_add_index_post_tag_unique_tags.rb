class AddIndexPostTagUniqueTags < ActiveRecord::Migration
  def change
    add_index :post_tags, [:post_id, :tag], :unique => true
  end
end
