class CreateMediaTable < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user
      t.string :content
      t.string :title
      t.string :post_type
    end

    create_table :media_urls do |t|
      t.belongs_to :post
      t.string :url
    end
  end
end
