class AddTypeToVideos < ActiveRecord::Migration
  def change
    change_table :user_video_posts do |t|
      t.string :type
    end
  end
end
