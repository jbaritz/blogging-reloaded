class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  has_many :subscribed_to_me, class_name: "Subscription", foreign_key: :subscribee_id
  has_many :subscribers, through: :subscribed_to_me

  has_many :subscribing_to, class_name: "Subscription", foreign_key: :subscriber_id
  has_many :subscribees, through: :subscribing_to

  has_many :original_posts
  has_many :reblogs



end
