class AddMoreStuffToPosts < ActiveRecord::Migration
  def change
    add_column :trends, :processed, :boolean, default: true
    add_column :posts, :score, :integer
  end
end
