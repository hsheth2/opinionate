class AddPosterToPost < ActiveRecord::Migration
  def change
    add_column :posts, :poster, :string
  end
end
