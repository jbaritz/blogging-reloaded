class CreateCommunityPosts < ActiveRecord::Migration
  def change
    create_table :community_posts do |t|
      t.references :post, polymorphic: true
      t.references :user
      t.references :community
    end
  end
end
