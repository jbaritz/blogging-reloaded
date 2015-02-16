class ChangePostsToOriginalPosts < ActiveRecord::Migration
  def change
    rename_table :posts, :original_posts
  end
end
