class ChangeTypetoVidType < ActiveRecord::Migration
  def change
    rename_column :user_video_posts, :type, :vid_type

  end
end
