class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :trend_id, index: true
      t.string :source
      t.string :url
      t.text :content

      t.timestamps null: false
    end
  end
end
