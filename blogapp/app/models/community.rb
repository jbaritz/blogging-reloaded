class Community < ActiveRecord::Base
  belongs_to :user
  has_many :posts
  has_many :subscriptions, as: :subscribed
end
