class UserBlogPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_blog_post, as: :post
end