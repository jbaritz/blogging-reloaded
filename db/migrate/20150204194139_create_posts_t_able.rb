class CreatePostsTAble < ActiveRecord::Migration
  def change
    create_table :user_blog_post do |t|
      t.references :user
      t.references :post, polymorphic: true
      t.timestamps null: false
    end
  end
end
