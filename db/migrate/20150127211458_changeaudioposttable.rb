class Changeaudioposttable < ActiveRecord::Migration
  def change
    rename_table :user_post_audios, :user_audio_posts
  end
end
