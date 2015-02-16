class ChangeCommentsImageableToMedia < ActiveRecord::Migration
  def change
    remove_column :comments, :imageable_id
    remove_column :comments, :imageable_type
    change_table :comments do |t| 
      t.references :media, polymorphic: true
    end

  end
end
