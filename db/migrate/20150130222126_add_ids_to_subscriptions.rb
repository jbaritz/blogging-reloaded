class AddIdsToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :subscriber_id, :integer
    add_column :subscriptions, :subscribee_id, :integer
  end
end
