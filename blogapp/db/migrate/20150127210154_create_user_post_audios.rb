class CreateUserPostAudios < ActiveRecord::Migration
  def change
    create_table :user_post_audios do |t|
      t.string :title
      t.text :content
      t.references :user, index: true
      t.string :audio_url
      t.string :tags

      t.timestamps null: false
    end
    add_foreign_key :user_post_audios, :users
  end
end
