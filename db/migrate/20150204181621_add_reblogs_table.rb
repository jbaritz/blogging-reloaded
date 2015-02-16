class AddReblogsTable < ActiveRecord::Migration
  def change
    create_table :reblogs do |t|
      t.references :post
      t.references :user
      t.timestamps null: false
    end
  end
end
