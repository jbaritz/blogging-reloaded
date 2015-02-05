class Reblog < ActiveRecord::Base
  belongs_to :original_post
  belongs_to :user
  belongs_to :user_blog_post, foreign_key: :post_id

 #you can just call "reblog.original_post" to grab all the post info for a reblog
end