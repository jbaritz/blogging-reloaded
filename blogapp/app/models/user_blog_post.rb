class UserBlogPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, polymorphic: true

end