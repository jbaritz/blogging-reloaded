class FixTables < ActiveRecord::Migration
  def up
    change_column :forum_posts, :body, :text
    change_column :original_posts, :content, :text
  end

   def down
    change_column :forum_posts, :body, :string
    change_column :original_posts, :content, :string
  end
end
