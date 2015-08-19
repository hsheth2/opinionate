class AddQueryToTrend < ActiveRecord::Migration
  def change
    add_column :trends, :query, :string
  end
end
