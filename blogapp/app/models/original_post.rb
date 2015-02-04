class OriginalPost < ActiveRecord::Base
  belongs_to :user
  has_many :media_urls, foreign_key: :post_id
  has_many :reblogs
  belongs_to :user_blog_post, foreign_key: :post_id
  acts_as_commentable

  def mediaurls
    x = self.media_urls
    x.map { |y| y } #doesn't do anything
  end
end
