class CreateUserPicturePosts < ActiveRecord::Migration
  def change
    create_table :user_picture_posts do |t|
      t.string :title
      t.text :content
      t.string :image_url
      t.references :user, index: true
      t.string :tags

      t.timestamps null: false
    end
    add_foreign_key :user_picture_posts, :users
  end
end
