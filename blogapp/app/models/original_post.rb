class OriginalPost < ActiveRecord::Base
  belongs_to :user
  has_many :media_urls, foreign_key: :post_id
  has_many :reblogs, foreign_key: :original_post_id
  acts_as_commentable
  acts_as_taggable

  def mediaurls
    x = self.media_urls
    x.map { |y| y } #doesn't do anything
  end
end
