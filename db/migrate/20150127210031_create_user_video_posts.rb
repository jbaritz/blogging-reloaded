class CreateUserVideoPosts < ActiveRecord::Migration
  def change
    create_table :user_video_posts do |t|
      t.string :title
      t.text :content
      t.string :video_url
      t.references :user, index: true
      t.string :tags

      t.timestamps null: false
    end
    add_foreign_key :user_video_posts, :users
  end
end
