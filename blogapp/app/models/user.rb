class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :subscriptions
  # belongs_to :subscription, as: :subscribed

  has_many :user_audio_posts
  has_many :user_picture_posts
  has_many :user_text_posts
  has_many :user_video_posts

  def get_posted_content
    audio = self.user_audio_posts
    pictures = self.user_picture_posts
    text = self.user_text_posts
    video = self.user_video_posts

    content = [audio, pictures, text, video].flatten

    content.sort_by { |c| c.created_at }
  end
end
