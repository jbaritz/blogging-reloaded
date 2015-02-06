class CreateCommunityMembers < ActiveRecord::Migration
  def change
    create_table :community_memberships do |t|
      t.references :user
      t.references :community
      t.boolean :admin

      t.timestamps null: false
    end
  end
end
