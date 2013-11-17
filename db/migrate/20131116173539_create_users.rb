class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :google_id
      t.boolean :is_admin
      t.string :email
      t.string :name
    end
  end
end
