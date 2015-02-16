class DropTableCommunityPost < ActiveRecord::Migration
  def change
    drop_table :community_posts
  end
end
