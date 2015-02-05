class UserBlogPost < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, polymorphic: true

  def get_post 
    if self.post_type == "OriginalPost"
      self.post
    elsif self.post_type == "Reblog"
      self.post.original_post
    end
  end
end