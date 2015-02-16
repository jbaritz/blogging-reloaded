class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.title :string
      t.content :text
      

      t.timestamps null: false
    end
  end
end
