class AddStuffToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :sentiment, :boolean
    add_column :posts, :service_id, :string
    add_index :posts, :service_id
  end
end
