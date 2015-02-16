class DropTheTables < ActiveRecord::Migration
  def change
    drop_table :user_audio_posts
    drop_table :user_text_posts
    drop_table :user_picture_posts
    drop_table :user_video_posts
  end
end
