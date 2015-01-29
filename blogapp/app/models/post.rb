class Post < ActiveRecord::Base
  belongs_to :user
  has_many :media_urls

  def media_urls
    x = self.media_urls
    x.map { |y| y.url }
  end
end
