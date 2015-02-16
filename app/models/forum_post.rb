class ForumPost < ActiveRecord::Base
  belongs_to :community
  belongs_to :user
  acts_as_commentable
end
