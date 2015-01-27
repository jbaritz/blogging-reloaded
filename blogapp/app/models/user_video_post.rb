class UserVideoPost < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :media
end
