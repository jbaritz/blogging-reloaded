class Reblog < ActiveRecord::Base
  belongs_to :original_post
  belongs_to :user
  belongs_to :user_blog_post, foreign_key: :post_id
end