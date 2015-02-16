class Changereblogcolumname < ActiveRecord::Migration
  def change
    rename_column :reblogs, :post_id, :original_post_id
  end
end
