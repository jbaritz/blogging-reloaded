class AddColumnToOriginalPosts < ActiveRecord::Migration
  def change
    add_column :original_posts, :community_post, :boolean
  end
end
