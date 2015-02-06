class Community < ActiveRecord::Base
  belongs_to :user
  has_many :posts
  has_many :community_memberships
  has_many :subscriptions, as: :subscribee
end
