class AddTypeToMediaUrls < ActiveRecord::Migration
  def change
    change_table :media_urls do |t|
      t.string :media_type
    end
  end
end
