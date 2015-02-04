class ChangeTableTitleUggh < ActiveRecord::Migration
  def change
        rename_table :user_blog_post, :user_blog_posts

  end
end
