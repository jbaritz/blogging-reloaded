class AddColumnToReblogs < ActiveRecord::Migration
  def change
    add_column :reblogs, :community_post, :boolean
  end
end
