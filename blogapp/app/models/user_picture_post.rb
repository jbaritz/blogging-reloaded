class UserPicturePost < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :media
end
