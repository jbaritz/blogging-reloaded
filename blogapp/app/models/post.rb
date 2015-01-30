class Post < ActiveRecord::Base
  belongs_to :user
  has_many :media_urls

  def mediaurls
    x = self.media_urls
    x.map { |y| y }
  end
end
