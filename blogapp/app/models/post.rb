class Post < ActiveRecord::Base
  belongs_to :user
  has_many :media_urls
  acts_as_commentable

  def mediaurls
    x = self.media_urls
    x.map { |y| y } #doesn't do anything
  end
end
