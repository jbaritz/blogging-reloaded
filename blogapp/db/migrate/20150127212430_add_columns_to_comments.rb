class AddColumnsToComments < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.references :user, index: true
      t.references :imageable, polymorphic: true, index: true
    end
  end
end
