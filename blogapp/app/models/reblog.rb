class Reblog < ActiveRecord::Base
  belongs_to :original_post
  belongs_to :user

 #you can just call "reblog.original_post" to grab all the post info for a reblog
end