class DropUserBlogPosts < ActiveRecord::Migration
  def change
    drop_table :user_blog_posts
  end
end
