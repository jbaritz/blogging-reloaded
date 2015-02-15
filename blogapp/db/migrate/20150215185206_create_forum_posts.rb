class CreateForumPosts < ActiveRecord::Migration
  def change
    create_table :forum_posts do |t|
      t.references :community
      t.references :user
      t.string :title
      t.string :body
      t.timestamps null: false
    end
  end
end
