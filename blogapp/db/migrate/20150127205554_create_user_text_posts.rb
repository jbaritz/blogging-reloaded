class CreateUserTextPosts < ActiveRecord::Migration
  def change
    create_table :user_text_posts do |t|
      t.string :title
      t.text :content
      t.references :user, index: true
      t.string :tags

      t.timestamps null: false
    end
    add_foreign_key :user_text_posts, :users
  end
end
